# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "bezier"))

class BezierUnit
  include BezierUnitBase

  def setup
    @mpoints << MovablePoint.new(self, @win.srect.center + Stylet::Vector.new(-@win.srect.w / 4, @win.srect.h / 4))
    @mpoints << MovablePoint.new(self, @win.srect.center + Stylet::Vector.new(0, -@win.srect.h / 4))
    @mpoints << MovablePoint.new(self, @win.srect.center + Stylet::Vector.new(@win.srect.w / 4, @win.srect.h / 4))
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
  def bezier_point(points, d)
    o = Stylet::Vector.new(0, 0)
    o += points[0].scale((1 - d) * (1 - d))
    o += points[1].scale(2 * d * (1 - d))
    o += points[2].scale(d * d)
  end
end

App.main_loop
