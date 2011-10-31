# -*- coding: utf-8 -*-
# バックトラックにより全消しパータンを調べる

require File.expand_path(File.join(File.dirname(__FILE__), "tetris")) # as require_relative("tetris")

require "observer"

class FieldHist < Field         # 履歴機能付きフィールド
  attr_accessor :history
  
  def initialize(*arg)
    super
    @history = []
  end
  
  def push_history(mino)       # 書き込み履歴を取る
    @history << mino
  end
  
  def pop_history               # 最新の履歴を削除
    @history.pop
  end
  
  alias inspect_old inspect
  
  def inspect
    %(#{"<0x%08x>" % self.object_id} #{width}*#{height} history.size=#{history.size})
  end
end

class BackTrack
  include Observable
  
  attr_reader :field
  
  # 全て探索する
  # 途中経過表示
  def initialize(minos, width=10, height=20, tryall=false, &pblock)
    @field = FieldHist.new([width, height])
    @minos = Mino::Classic.pattern_to_alpha_str_pattern(minos.to_s).scan(/./)
    @tryall = tryall
    @log = []
    @callback = pblock
    @history = []
  end
  
  def backtrack(index = 0)
    return false if @minos.empty?
    mino = Mino::Classic.create(@minos[index])
    mino.attach(@field)
    mino.each_dir {|dir|
      mino.dir.set(dir) # 方向設定
      mino.set_start_pos        # 初期位置にブロックを配置
      mino.dash(Point::LEFT) # 一番左に移動
      # ブロックを左から右に順に置いていく
      loop {
        mino.fall              # 下に落とす
        mino.puton              # フィールドに書き込み
        @field.push_history(mino)
        changed
        notify_observers(@field)
        if @field.damage == 0 # フィールドに隙間が無い状態?
          # 全てのブロックを使ってACならここに
          # (index == @minos.length-1) のチェックを入れる
          if @field.all_clear?
            # @log に入っていないフィールドのみ追加する
            unless @log.detect{|e|e.to_s == @field.to_s}
              @log << @field.clone.freeze
              if @callback
                @callback.call(@field)
              end
              return true unless @tryall
            end
          end
          ################################################################################
          if index < @minos.length-1
            if can_ac_by_rest_mino?(index)
              if backtrack(index+1) # まだブロックが残っているので次のブロックを試す
                return true
              end
            end
          end
          ################################################################################
        end
        mino.putoff             # 置いたブロックは外す
        @field.pop_history
        mino.dash(Point::UP) # 一旦上に飛ばす
        break unless mino.moveable?(Point::RIGHT) # これ以上右に移動できなかったら中止する
        mino.move(Point::RIGHT) # 右に一つ移動する
      }
    }
    false
  end

  # 見るからに残りのブロックでは全消しできそうにない高い積み方を排除す
  # る。具体的には、水平に埋めるために必要なセル数より、残りブロックか
  # ら得られるセル数が同じか上まわっているかを調べる。上まわっていれば
  # 全消しの可能性がある。
  def can_ac_by_rest_mino?(index)
    need_cell_count = @field.get_cell_count_for_ac # 埋めるのに必要なセル数
    rest_cell_count = 0     # 残りのブロックから得られるセル数を取得
    @minos[index+1..-1].each{|no| rest_cell_count += Mino::Classic.create(no).class.get_cell_num}
    need_cell_count <= rest_cell_count
  end

  def result
    @log
  end

  def display
    $stdout << result
  end

  alias inspect_old inspect
  def inspect
    %(log.size=#{@log.size})
  end
end

if $0 == __FILE__
  backtrack = BackTrack.new("yrr", 6, 8, true)
  catch(:exit) {
    backtrack.backtrack
  }
  backtrack.display
end
