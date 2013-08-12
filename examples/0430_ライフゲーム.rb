# -*- coding: utf-8 -*-
#
# ライフゲーム
#
require_relative "helper"

class Lifegame
  AroundVectors = [
    Stylet::Vector.new(-1, -1), Stylet::Vector.new(0, -1), Stylet::Vector.new(1, -1),
    Stylet::Vector.new(-1,  0),                            Stylet::Vector.new(1,  0),
    Stylet::Vector.new(-1, +1), Stylet::Vector.new(0, +1), Stylet::Vector.new(1, +1),
  ]

  def initialize(win)
    @win = win

    @matrixs = Array.new(2){{}}
    @generation = 0
    @cell_list_index = 0

    @size = 12

    if true
      @width  = @win.rect.width / @size
      @height = @win.rect.height / @size
    else
      @width  = 32
      @height = 32
    end

    reset
  end

  def reset
    @generation = 0
    @matrixs[0].clear
    object_list[@cell_list_index.modulo(object_list.size)].strip.lines.each_with_index{|line, y|
      line.chars.each_with_index{|char, x|
        if char.match(/[oO■]/)
          @matrixs[0][[x, y]] = true
        end
      }
    }
  end

  def next_generation
    if @win.button.btA.repeat == 1 || @win.button.btB.repeat == 1
      @cell_list_index += (@win.button.btA.repeat_0or1 - @win.button.btB.repeat_0or1)
      reset
    end
    if @win.button.btC.repeat == 1
      reset
    end

    @matrix = @matrixs[@generation.modulo(@matrixs.size)]
    @next_matrix = @matrixs[@generation.next.modulo(@matrixs.size)]

    # (-@height).step(@height - 1) do |y|
    #   (-@width).step(@width - 1) do |x|
    0.step(@height - 1) do |y|
      0.step(@width - 1) do |x|
        vec = Stylet::Vector.new(x, y)
        count = AroundVectors.count{|v|
          @matrix[(vec + v).to_a.collect(&:to_i)]
        }
        @next_matrix[vec.to_a] = @matrix[vec.to_a] ? (count == 2 || count == 3) : (count == 3)
      end
    end

    @generation += 1
  end

  def display
    if @next_matrix
      @next_matrix.each{|xy, cell|
        if cell
          v = Stylet::Vector.new(*xy)
          v = (v * @size) + @win.rect.to_vector + @win.cursor.point
          @win.draw_rect(Stylet::Rect.new(*v.to_a, @size, @size), :fill => true, :color => "font")
        end
      }
    end
  end

  def update
    next_generation
    display
  end

  def object_list
    [
      "
.........................o
.......................o.o
.............oo......oo............oo
............o...o....oo............oo
.oo........o.....o...oo
.oo........o...o.oo....o.o
...........o.....o.......o
............o...o
.............oo
",
      "
.............
.............
..oooooo.oo..
..oooooo.oo..
.........oo..
..oo.....oo..
..oo.....oo..
..oo.....oo..
..oo.........
..oo.oooooo..
..oo.oooooo..
.............
.............
",
      "
.......o.........
........o........
....o...o........
.....oooo........
.................
.................
.................
....o............
.....oo..........
......o..........
......o..........
.....o...........
.................
.................
.......o.........
........o........
....o...o........
.....oooo........
.................
",
      "
□□□□□□□□□□□□□□□□□
□□□□□□□□□□□■■□□□□
□□□□□□□□■■■□■■□□□
□□□□□□□□■■■■■□□□□
□□□□□□□□□■■■□□□□□
□□□□□□□□□□□□□□□□□
□□□□□□□□□□□□□□□□□
□□□□□□□□■■■■■■■■□
□■□□□■□□□□□□□□□■□
□■□□□■□□□□□□□□□■□
□■□□□■□□□□□□□□■□□
□□□□□□□□□□□□□□□□□
□■□□□■□□□□□□□□■□□
□■□□□■□□□□□□□□□■□
□■□□□■□□□□□□□□□■□
□□□□□□□□■■■■■■■■□
□□□□□□□□□□□□□□□□□
□□□□□□□□□□□□□□□□□
□□□□□□□□□■■■□□□□□
□□□□□□□□■■■■■□□□□
□□□□□□□□■■■□■■□□□
□□□□□□□□□□□■■□□□□
□□□□□□□□□□□□□□□□□
",
      # Puff suppressor
      "
....................O............
...................O.OO..........
.................O...OO..........
...........O.....O.OO...O........
.O.O.......OOOO...OO.OOOO........
.O..O.O.....OOO....O......O......
....O..O....O...O...OOOOOOO......
..O....OO.O.O...O..OO......O.O...
...O........OO..O.....OOOOOOOOO..
O..O...OOOO.OO.O..............OO.
...O.O..O...O..........O.OO....OO
O..O.O.O......OOO........O....OO.
..OO....O......OO......O.........
O..O.O.O......OOO........O....OO.
...O.O..O...O..........O.OO....OO
O..O...OOOO.OO.O..............OO.
...O........OO..O.....OOOOOOOOO..
..O....OO.O.O...O..OO......O.O...
....O..O....O...O...OOOOOOO......
.O..O.O.....OOO....O......O......
.O.O.......OOOO...OO.OOOO........
...........O.....O.OO...O........
.................O...OO..........
...................O.OO..........
....................O............
",
    ]
  end
end

class App < Stylet::Base
  include Helper::CursorWithObjectCollection

  def before_run
    super if defined? super
    @objects << Lifegame.new(self)
    self.title = "ライフゲーム"
  end
end

App.run
