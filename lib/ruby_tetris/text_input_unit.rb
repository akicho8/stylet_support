# -*- coding: utf-8 -*-
################################################################################
# 次に入力の違いを考慮したクラスを3つ定義する
# 1. TextInputUnit - プログラムとして自動的に動かせる
# 2. Player1  - キーボード1P
# 3. Player2  - キーボード2P
################################################################################
#
# 表記
# *    次のブロックが操作可能になるまで待つ
# A*   次のブロックが操作可能になるまで待つ(Aを押しっぱなしなのでIRSが発動する。IRSが失敗する場合もある)
# r    右を押す
# r|   右を押す(壁かブロックに衝突するまで)
# _    下に衝突するまで待つ
# d_   下を押しながら下に衝突するまで待つ
# u    上を押す
# r+   右をずっと押しながら溜めが可能になるまで待つ
# 5    5フレーム待つ
# A5   Aを押したまま5フレーム待つ
# .    何もしない(主にボタンを放すのに使う)
# A . A  Aボタン押す→Aボタン放す→Aボタンを押す(A A だとAを押しっぱなしとみなす)
# Ar   Aボタンと右を同時に押す
#
class TextInputUnit < InputUnit
  #
  # 引数タイプ
  #
  # 1. ["A","B","C"]
  # 2. "A,B,C"
  # 3. ["A,B","C"]
  # 4. "A","B","C"
  #
  # 元々 1 だけだった。でも 2,3,4 も取れるようにしてみた。
  # でも、[""]*3 が [] になってしまってややこしいので廃止
  #
  # 変換過程
  # p inkey                                    #=> ["A , B", "", ["A , B"],"",["A,B"]]
  # p inkey.flatten.join(",")                  #=> "A , B,,A , B,,A,B"
  # p inkey.flatten.join(",").split(/\s*,\s*/) #=> ["A", "B", "", "A", "B", "", "A", "B"]
  #
  def initialize(inkey)
    super()
    # 最後の map は [",,"] => [nil,nil,nil] => ["","",""] となるように nil を "" に変換

    if inkey.is_a? String       # 文字列の場合スペース区切りで分ける
      str = inkey.gsub(/\n/, "")
      str.strip!
      @inkey = str.split(/\s+/)
    else
      @inkey = inkey.flatten    # Array型の場合はいままでの仕様と変わらない
    end

    @save_key = ""              # 反映するキー文字列("lrudABCD"と属性"*|_+"と待ち時間がごっちゃになっている)
    @delay_count = 0            # 任意の待ち時間が有効になったときにセットされてデクリメントされる
  end

  def update(player=nil)
    if @delay_count > 0         # 任意の時間待ち
      @delay_count -= 1
    elsif @save_key.include?("*") # IRS待ち
    elsif @save_key.include?("|") # 左右の壁衝突待ち
    elsif @save_key.include?("_") # 下への衝突待ち
    elsif @save_key.include?("+") # 溜め待ち
      if key_power_effective?(player.controller.power_delay)
        @save_key = ""
      end
    else
      # 何の待ちイベントも発生していないので空にしておく
      # ここが呼ばれるのは delay_count が終了したときだけかな。
      @save_key = ""
    end

    # 待ってない場合のみ次のデータを取得できる
    if @save_key.empty?
      throw :exit, :lost_key if @inkey.empty?
      @save_key = @inkey.shift
      if /(\d+)/ =~ @save_key   # 数値が指定されていれば時間待ちと見なす
        @delay_count = $1.to_i - 1
      end
    end

    # 最新データとして反映
    key_objects.each{|v| v << @save_key}

    # p "#{@save_key}, #{@delay_count}"
  end

  # IRSの直後に呼ばれる。
  # IRSの成功したかどうかには関係がない。
  # だからブロックが操作可能になるまで待つというのにも使える。
  def after_user_irs(*args)
    if @save_key.include?("*")
      @save_key = ""
      # p "after_user_irs"
    end
  end

  def after_move(mino, dir)
    if @save_key.include?("|")
      if dir
        unless mino.moveable?(dir)
          @save_key = ""
          # p "after_move"
        end
      end
    end
    if @save_key.include?("_")
      unless mino.moveable?(Point::DOWN)
        @save_key = ""
      end
    end
  end

end

class RSTextInputUnit < TextInputUnit
  require File.expand_path(File.join(File.dirname(__FILE__), "reaction_suppression")) # as require_relative("reaction_suppression")
  include ReactionSuppressionModule
end
