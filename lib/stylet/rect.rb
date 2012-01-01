module Stylet
  class Rect
    def self.create(*args)
      new(*args)
    end

    def initialize(x, y, w, h)
      @x = x
      @y = y
      @width = w
      @height = h
    end

    def min_x
      @x
    end

    def max_x
      @x + @width - 1
    end

    def min_y
      @y
    end

    def max_y
      @y + @height - 1
    end

    def half_x
      @x + @width / 2
    end

    def half_y
      @y + @height / 2
    end

    def half_pos
      Vector.new(half_x, half_y)
    end
  end
end

if $0 == __FILE__
  p0 = Stylet::Vector.new(1, 1)
  p1 = Stylet::Vector.new(1, 1)
  p(p0 == p1)
end
