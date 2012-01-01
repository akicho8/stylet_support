# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "bezier"))

class App < Bezier
  def before_main_loop
    super if defined? super

    @points << MovablePoint.new(self, min_x + half_x / 4, half_y)              # 開始
    @points << MovablePoint.new(self, min_x + half_x / 2, half_y - half_y / 2) # 制御(右)
    @points << MovablePoint.new(self, max_x - half_x / 2, half_y - half_y / 2) # 制御(左)
    @points << MovablePoint.new(self, max_x - half_x / 4, half_y)              # 終了

    update_title
  end

  # 三次ベジェ曲線
  #
  #   p0: 開始
  #   p1: 制御
  #   p2: 制御
  #   p2: 終了
  #
  #        p1           p2
  #   p0 ------------------- p3
  #
  #   用途
  #   ・激しく曲げたい
  #   ・終了座標を必ず通る必要がある
  #   ・計算量をまーまー少なくしたい
  #   ・クロスさせたい
  #
  def bezier_point(p, d)
    o = Stylet::Vector.new(0, 0)

    v = (1 - d) * (1 - d) * (1 - d)
    o.x += v * p[0].x
    o.y += v * p[0].y

    v = 3 * d * (1 - d) * (1 - d)
    o.x += v * p[1].x
    o.y += v * p[1].y

    v = 3 * d * d * (1 - d)
    o.x += v * p[2].x
    o.y += v * p[2].y

    v = d * d * d
    o.x += v * p[3].x
    o.y += v * p[3].y

    o
  end
end

App.main_loop
