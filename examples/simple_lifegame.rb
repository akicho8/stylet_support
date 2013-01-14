# -*- coding: utf-8 -*-
#
# ライフゲームの素
#

module LifeGame
  class Vector
    attr_accessor :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def +(other)
      self.class.new(@x + other.x, @y + other.y)
    end

    def to_a
      [@x, @y]
    end
  end

  class Base
    AroundVectors = [
      Vector.new(-1, -1), Vector.new(0, -1), Vector.new(1, -1),
      Vector.new(-1,  0),                    Vector.new(1,  0),
      Vector.new(-1, +1), Vector.new(0, +1), Vector.new(1, +1),
    ]

    attr_accessor :generation, :matrixs

    def initialize
      @matrixs = []

      @generation = 0
      @matrixs[0] = {}
      @matrixs[1] = {}

      @width  = 3
      @height = 3
    end

    def build
      @matrix = @matrixs[@generation.modulo(@matrixs.size)]
      @matrix2 = @matrixs[@generation.next.modulo(@matrixs.size)]

      @height.times do |y|
        @width.times do |x|
          vec = Vector.new(x, y)
          count = AroundVectors.count{|v|@matrix[(vec + v).to_a]}
          @matrix2[vec.to_a] = @matrix[vec.to_a] ? (count == 2 || count == 3) : (count == 3)
        end
      end
    end

    def to_s
      @matrix2 = @matrixs[@generation.next.modulo(@matrix2.size)]
      @height.times.collect do |y|
        @width.times.collect do |x|
          @matrix2[[x, y]] ? "o" : "."
        end.join + "\n"
      end.join
    end
  end
end

app = LifeGame::Base.new
app.matrixs[0][[1, 0]] = true
app.matrixs[0][[1, 1]] = true
app.matrixs[0][[1, 2]] = true
app.build
puts app
app.generation += 1
app.build
puts app

# >> ...
# >> ooo
# >> ...
# >> .o.
# >> .o.
# >> .o.
