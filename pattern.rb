#!/usr/local/bin/ruby -Ku
# ブロックツモ処理

require "tetris"

module Pattern

  # ブロックツモ用乱数
  class Random
    def initialize(seed=rand(32767))
      @seed = seed
    end

    def get_next(num=nil)
      @seed = @seed * 214013 + 2531011
      @seed = @seed & 0x7fffffff
      r = (@seed >> 16) & 0x7fff
      r = r.modulo(num) if num
      r
    end
  end

  # ベースクラス
  class Base
    def self.algorithm            # abstract
    end

    def initialize
      @get_first = true
    end

    def get_next                  # abstract
    end

    def get_next2                 # 最初に出るのを嫌がるブロックを排除
      v = get_next
      if @get_first
        v = get_next until Mino::Classic.list[v].first_appear?
        @get_first = false
      end
      v
    end

    def clone
      Marshal.load(Marshal.dump(self))
    end
  end

  # 7種類x2ブロックを用意しシャッフルして順番に出す。
  class Shuffle < Base
    def self.algorithm; "シャッフル型"; end

    def initialize(seed=Time.now.usec, size=Mino::Classic.list.size*2)
      super()
      @rand = Random.new(seed)
      @size = size
      make_pattern
    end

    def get_next
      make_pattern if @pool.empty?
      @pool.shift
    end

    private
    def make_pattern
      @pool = []
      @size.times {|v| @pool.push(v.modulo(Mino::Classic.list.size))}
      @size.times {|a|
        b = @rand.get_next(@size)
        @pool[b], @pool[a] = @pool[a], @pool[b]
      }
    end
  end

  # 数十ブロック前までの出現頻度を見てブロックを調整
  class History < Base
    def self.algorithm; "履歴参照型"; end

    def initialize(seed=Time.now.usec, trys=4, depth=4)
      super()
      @rand = Random.new(seed)
      @trys = trys
      @depth = depth
      @hist = Array.new(@depth)
    end

    alias inspect_old inspect
    def inspect
      "trys=#{@trys} depth=#{@depth}"
    end

    def get_next
      mino = @rand.get_next(Mino::Classic.list.size)
      @trys.times {
        break unless @hist.include?(mino)
        mino = @rand.get_next(Mino::Classic.list.size)
      }
      @hist.unshift(mino)
      @hist.pop
      mino
    end
  end

  # 引数で指定したパターン通りに出現
  class Original < Base
    def self.algorithm; "独自型"; end

    def initialize(*order)
      super()
      @order = order.to_s.scan(/./)
    end

    def get_next
      @order.shift
    end

    def get_next2
      get_next
    end
  end


  ################################################################################
  # 履歴取得機能の付きのクラス定義
  ################################################################################

  # クラス設計の別の案
  #
  # (1) 実装クラスを継承して履歴機能を付加する。
  #     問題点: 対応するクラスが多い。メンバ変数のバッティング。
  # (2) Patternクラスの get_next の中で get_next2 を呼びながら履歴を取る。
  #     サブクラスは get_next2 を再定義する。
  # (3) Patternクラスのクラスメソッドとしてcreateを定義し FooPattern をカプセル化する。
  #     例: newobj = Record.new(FooPattern.new(*arg))
  # (4) クラスメソッドとしてcreateを定義し Record を observer で呼ばれるようにする。
  #     例: newobj = FooPattern.new(*arg); Record.new(newobj); return newobj
  #
  # 以下は(1)を使った。

  # @hist だと History のメンバと衝突するので注意。
  module Record
    attr_reader :history
    def get_next2
      @history ||= []
      @history << super
      @history.last
    end
  end

  class ShuffleRec < Shuffle;   include Record; end
  class HistoryRec < History;   include Record; end
  class OriginalRec < Original; include Record; end
end

################################################################################
# テスト
################################################################################

if $0 == __FILE__
  module Pattern
    module Test
      module_function
      def test_num(klass, num=50)
        pattern = klass.new
        $stdout << "#{pattern.class.algorithm.rjust(16)}:"
        num.times {$stdout << pattern.get_next}
        $stdout << "\n"
      end

      # 青の後の先に来るのが青かそれとも橙か?
      # その比率を調べて返す
      def check_rate(pattern)
        loop_count = 1000
        blue = 0
        orenge = 1
        prev = nil
        same = 0
        diff = 0
        loop_count.times {|i|
          r = pattern.get_next
          if prev == blue
            if r == blue
              prev = nil
              same += 1
            elsif r == orenge
              prev = nil
              diff += 1
            end
          end
          if r == blue
            prev = blue
          end
        }
        begin
          n = (same + diff).to_f
          a = same / n
          b = diff / n
          rate = b/a
        rescue
        end
        "#{pattern.class} total:#{n.to_i} blue:%0.3f orenge:%0.3f rate:%0.3f" % [a, b, rate]
      end
    end
  end

  1.upto(7) {|depth|
    1.upto(7) {|trys|
      str = Pattern::Test.check_rate(Pattern::History.new(0, trys, depth))
      $stdout << "#{str} trys=#{trys} depth=#{depth}\n"
    }
  }
end
