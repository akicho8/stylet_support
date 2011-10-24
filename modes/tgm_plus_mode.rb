#!/usr/local/bin/ruby -Ku


$LOAD_PATH << ".." if $0 == __FILE__
require "tgm_mode"
require "shuffler"

# 出現間隔(inter), 穴数(holes), 高さ(lines)

TGMPlusTable = [
  [(10..15), (1..1), (1..2)],   # 000
  [(10..15), (1..2), (1..2)],   # 100
  [(5..10),  (1..1), (1..3)],   # 200
  [(5..10),  (1..2), (1..2)],   # 300
  [(10..15), (1..1), (1..1)],   # 400 簡単にする
  [(2..5),   (1..1), (1..1)],   # 500
  [(15..20), (1..1), (1..2)],   # 600
  [(10..15), (1..1), (1..2)],   # 700
  [(15..20), (1..1), (1..2)],   # 800 簡単にする
  [(1..5),   (1..2), (1..4)],   # 900
]

# 独立Plusクラス。Moduleとしてそのまま作るメリットがまったくない。それ
# どころか他のメンバと名前が衝突する可能性がある。これはもはや、グロー
# バル変数領域でコードを定義しているようなもの。なので、クラスにした。

class LineCreater
  attr_accessor :pos
  def initialize
  end

  def set_table(table)
    @rand = Pattern::Random.new(Time.now.usec)
    @table = table
    @pos = 0
    reset_trigger
  end

  def current
    t = @table[@pos]
    t = @table.last if t.nil?
    t
  end

  def reset_trigger
    inter, holes, lines = current
    @trigger = inter.first + @rand.get_next(inter.to_a.length) # ruby <= 1.6 なら inter.length
    @count = 0
  end

  # [[1,2],[3,4]] のようなのを返す。[1,2]は一つ目で1,2桁が空きという意味。
  def nums_aryary(width)
    reset_trigger
    inter, holes, lines = current
    holes = holes.first + @rand.get_next(holes.to_a.length)
    lines = lines.first + @rand.get_next(lines.to_a.length)
    if same_mino_ok?
      # 同じ形で複数段
      [Shuffler.shuffle_by((0...width).to_a, @rand)[0...holes]] * lines
    else
      # 異なる形で複数段
      (0...lines).collect{Shuffler.shuffle_by((0...width).to_a, @rand)[0...holes]}
    end
  end

  def same_mino_ok?
    true
  end

  def cell_aryary(field)
    if @count < @trigger
      @count += 1
      return []
    end
    to_cell_aryary(nums_aryary(field.width), field.width)
  end

  def to_cell_aryary(aryary, width)
    aryary.collect{|ary| # ary=[1,2]
      cells = (0...width).collect{
        colors = Mino::Classic.validity_alpha_colors
        color = colors[@rand.get_next(colors.size)]
        LifeCell.new(color)
      }
      ary.each{|i|cells[i].clear!}
      cells #=> [on, off, off, on, on, .....] (Cell2のインスタンスの配列)
    }
  end
end

module TGMPlus
  attr_reader :plus
  def initialize
    super
    @plus = LineCreater.new
  end

  def block_up_call_signal(field)
    @plus.pos = @segment_level
    @updata.concat(@plus.cell_aryary(field))
  end
end

class TGMPlusController < TGMController
  include TGMPlus
  def initialize
    super
    @mode_name = "TGM+"
    @plus.set_table(TGMPlusTable)
  end
end

module Modes
  class FrameTGMPlus < MementFrame
    Name = "TGM+"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, TGMPlusController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameTGMPlus.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
