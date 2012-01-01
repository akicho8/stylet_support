require File.expand_path(File.join(File.dirname(__FILE__), "vector"))

module Stylet
  module ScreenAccessors
    def min_x
      0
    end

    def max_x
      @screen.w - 1
    end

    def width
      @screen.w
    end

    def half_x
      @screen.w / 2
    end

    def min_y
      0
    end

    def max_y
      @screen.h - 1
    end

    def height
      @screen.h
    end

    def half_y
      @screen.h / 2
    end

    def half_pos
      Vector.new(half_x, half_y)
    end
  end
end
