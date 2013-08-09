# -*- coding: utf-8 -*-
#
# 多角形描画
#
module Stylet
  module DrawSupport
    # 多角形描画
    #   draw_polygon([Vector.new(0, 0), Vector.new(0, 100), Vector.new(50, 50)])
    def draw_polygon(points, options = {})
      points.size.times{|i|
        p0 = points[i]
        p1 = points[i.next % points.size]
        draw_line(p0, p1, options)
      }
    end
  end

  if $0 == __FILE__
    require_relative "../../stylet"
    Base.run do |win|
      points = Array.new(3 + rand(3)){Vector.new(rand(win.rect.w), rand(win.rect.h))}
      win.draw_polygon(points)
      win.draw_polygon([Vector.new(0, 0), Vector.new(0, 100), Vector.new(50, 50)])
      sleep(0.25)
    end
  end
end
