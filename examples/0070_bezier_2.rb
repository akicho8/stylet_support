# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "bezier"))

class App < Bezier
  def before_main_loop
    super if defined? super

    # 3点
    @points << MovablePoint.new(self, half_x - half_x / 2, half_y + half_y / 2)
    @points << MovablePoint.new(self, half_x             , half_y - half_y / 2)
    @points << MovablePoint.new(self, half_x + half_x / 2, half_y + half_y / 2)

    update_title
  end

  # 二次ベジェ曲線
  #
  #   p0: 開始座標
  #   p1: 制御座標
  #   p2: 終了座標
  #
  #              p1
  #   p0 ------------------- p2
  #
  #   用途
  #   ・少し曲げたい
  #   ・終了座標を必ず通る必要がある
  #   ・計算量をなるべく少なくしたい
  #   ・クロスしなくてよい
  #
  def bezier_point(p, d)
    o = Stylet::Point.new(0, 0)

    v = (1 - d) * (1 - d)
    o.x += v * p[0].x
    o.y += v * p[0].y

    v = 2 * d * (1 - d)
    o.x += v * p[1].x
    o.y += v * p[1].y

    v = d * d
    o.x += v * p[2].x
    o.y += v * p[2].y

    o
  end
end

App.main_loop
