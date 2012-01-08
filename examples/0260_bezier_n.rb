# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "bezier"))

class BezierUnit
  include BezierUnitBase

  def setup
    case true
    when true
      # 横に配置
      n = 2
      @mpoints += Array.new(n + 1){|i|
        x = (@win.srect.width * 0.1) + ((@win.srect.width * 0.8) / n * i)
        y = @win.srect.half_y
        MovablePoint.new(self, Stylet::Vector.new(x, y))
      }
    when true
      # 円状に配置
      n = 5
      r = half_y * 0.9
      @mpoints += Array.new(n){|i|
        MovablePoint.new(self, @win.srect.center + Stylet::Vector.sincos(1.0 / n * i).scale(r))
      }
    end
  end

  # N次ベジェ曲線
  #
  #         p1  p2  p3  p4
  #   p0 ------------------- p5
  #
  #   用途
  #   ・めちゃくちゃ激しく曲げたい
  #   ・終了座標を必ず通る必要がある
  #   ・どんだけ計算量がかかってもよい
  #   ・クロスしまくりたい
  #
  def bezier_point(points, d)
    o = Stylet::Vector.new(0, 0)

    points.size.times{|i|
      p = points[i]
      v = 1.0
      a = points.size - 1
      b = i
      c = a - b
      loop do
        if a > 1
          v *= a
          a -= 1
        else
          break
        end
        if b > 1
          v /= b
          b -= 1
        end
        if c > 1
          v /= c
          c -= 1
        end
      end
      v *= (d ** i) * ((1 - d) ** ((points.size - 1) - i))
      o += p.scale(v)
    }
    o
  end
end

App.main_loop
