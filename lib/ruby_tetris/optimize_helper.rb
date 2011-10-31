#!/usr/local/bin/ruby -Ku
# ブロック操作最適化の表を作るためのヘルパ

$LOAD_PATH << '..'
require "simulator"

module OptimizeHelper
  module_function

  # 文字列で指定したブロックの形がはまるフィールドを作成する
  #
  # 例: p Field.make_hole_field(Mino.create("b"))
  #
  # 19|c..ccccccc|
  # 20|c.cccccccc|
  # 21|c.cccccccc|
  #    ----------
  #    0123456789
  #
  def make_hole_field(mino, options = {})
    options = {
      :mino_factory => Mino::World, # ブロックのタイプ
      :field_color => "x",            # フィールド色が明示されればその色を使う
      :random_cells => false,         # フィールド内のセルはランダムにするか?
      :field => Field.create,         # 使うフィールド
      :up_times => 0,                 # 何段上げるか?(見栄えをよくするために指定段数持ち上げる)
    }.merge(options)

    mino_list = options[:mino_factory].validity_alpha_colors

#     # フィールドの色は指定minoの次のブロック色が割り当てられる。
#     unless options[:field_color]
#       options[:field_color] = mino_list[mino_list.index(mino.color).succ.modulo(mino_list.size)]
#     end
#    options[:field_color] = "x"

    mino.clone.instance_eval {
      attach(options[:field])
      fall
      options[:up_times].times{move(Point::UP)}
      # move(Point::UP)を実行するごとにブロックは上にあがった(空に浮いた)状態になる。

      # ブロックを書き込んだ状態で処理する。抜けたらブロックがあった場所だけ消される。
      puton{
        field.width.times{|x|
          field.bottom.downto(field.get_top){|y|
            c = field.get(x, y)
            break if c.exist?
            if options[:random_cells]
              c.set(mino_list.at((x+y).modulo(mino_list.size)))
            else
              c.set(options[:field_color])
            end
          }
        }
      }

      # 一行そろっている行は右端を消す
      field.complate_info.each{|y|
        field.get(field.right, y).clear!
      }

      field.to_s(:ustrip => true)
    }
  end

  # ブロックを置いたときのブロック占有する列値を配列で返す
  #
  # 例: p Mino::World.mino_width("br1")
  #
  # フィールド状態は
  #
  # 19|c..ccccccc|
  # 20|c.cccccccc|
  # 21|c.cccccccc|
  #    ----------
  #    0123456789
  #
  # となるので戻り値は [1,2]
  #
  def mino_width(mino, field=Field.create)
    mino.clone.instance_eval {
      attach(field)
      puton{
        (field.left .. field.right).collect{|x|
          x if field.get_top2(x) >= 1
        }.compact
      }
    }
  end

  # 操作する文字列から難易度を適当に調べる。
  #
  # 法則
  # 1. ボタンを押す回数に比例して難しい
  # 2. レバーを左右に入れると難しい
  # 3. 難易度は1から始まる
  #
  # 例  "l| r A C d_ *" => 4
  #
  def to_difficulty_level_from_input_string(input_string)
    # 回転数が難易度初期値
    level = input_string.count("A-D")

    # レバーを左右に入れる場合
    if input_string.include?("l") && input_string.include?("r")
      level += input_string.count("l") + input_string.count("r") - 1 # 難易度1からにするための -1
    end

    level + 1
  end
end

if $0 == __FILE__

#   mino = Mino::World.create("b")
#   mino.dir.set("r")
#   mino.x = 1
#   p mino

#   fail unless OptimizeHelper.mino_width(mino) == [1,2]

#   fail unless OptimizeHelper.make_hole_field(mino) == <<-EOT
# c..cccccc.
# c.ccccccc.
# c.ccccccc.
# ccccccccc.
# ccccccccc.
# ccccccccc.
# ccccccccc.
# ccccccccc.
# ccccccccc.
#       EOT

#   fail unless Simulator.to_difficulty_level_from_input_string("l| r A C d_ *") == 4
end
