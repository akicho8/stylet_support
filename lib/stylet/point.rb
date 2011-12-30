# -*- coding: undecided -*-
module Stylet
  class Point < Struct.new(:x, :y)
    def initialize(*)
      super
    end

    def +(target)
      self.class.new(x + target.x, y + target.y)
    end

    def -(target)
      self.class.new(x - target.x, y - target.y)
    end

    def distance(target)
      dx = (x - target.x).abs
      dy = (y - target.y).abs
      Math.sqrt((dx ** 2) + (dy ** 2))
    end

    def rdirf(target)
      Stylet::Fee.rdirf(x, y, target.x, target.y)
    end
  end
end

if $0 == __FILE__
  p0 = Stylet::Point.new(1, 1)
  p1 = Stylet::Point.new(1, 1)
  p(p0 == p1)
  p2 = p0 + p1
  p p2
end
