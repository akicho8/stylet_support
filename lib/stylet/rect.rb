module Stylet
  class Rect < Struct.new(:x, :y, :w, :h)
    def self.create(*args)
      new(*args)
    end

    def min_x
      x
    end

    def max_x
      x + w - 1
    end

    def min_y
      y
    end

    def max_y
      y + h - 1
    end

    def half_x
      x + w / 2
    end

    def half_y
      y + h / 2
    end

    alias width w
    alias height h

    def half_pos
      Vector.new(half_x, half_y)
    end
  end
end

if $0 == __FILE__
  p Stylet::Rect.new(2, 3, 4, 5)
end
