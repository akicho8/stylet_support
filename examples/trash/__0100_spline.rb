# -*- coding: utf-8 -*-
require_relative "bezier"

class App < Bezier
  def before_main_loop
    super if defined? super

    case true
    when true
      # 横に配置
      n = 2
      @points = Array.new(n + 1){|i|
        x = (width * 0.1) + ((width * 0.8) / n * i)
        y = hy
        MovablePoint.new(self, x, y)
      }
    when true
      # 円状に配置
      n = 5
      r = hy * 0.9
      @points = Array.new(n){|i|
        x = hx + Stylet::Fee.cos(1.0 / n * i) * r
        y = hy + Stylet::Fee.sin(1.0 / n * i) * r
        MovablePoint.new(self, x, y)
      }
    end

    update_title
  end

  def coefficent(t)
    r = nil
    d = nil
    if t < 0.0
      t = -t
    end
    if t < 1.0
      r = (3.0 * t * t * t -6.0 * t * t + 4.0) / 6.0
    elsif t < 2.0
      d = t - 2.0
      r = -d * d * d / 6.0
    else
      r = 0.0
    end
    r
  end

  # Bスプライン
  # http://www1.u-netsurf.ne.jp/~future/HTML/bspline.html

  # _step = @points.size * 0.01;
  # -1.0.step(@points.size, _step){|t|
  #   draw_spline(@points, t)
  # }

  def bezier_point(points, d)
    interpolate = 20
    o = Stylet::Vector.new(0, 0)

    x = 0.0
    y = 0.0
    -2.step(points.size + 2){|j|
      k = j
      if j < 0
        k = 0
      end
      if j >= points.size
        k = points.size - 1
      end
      cn = coefficent(t - j)
      x += points[k] * cn
      y += points[k] * cn
    }
    Vector.new(x.to_i, y.to_i)
  end
end

App.run
