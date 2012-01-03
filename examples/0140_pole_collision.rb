# -*- coding: utf-8 -*-
#
# 円と点の衝突
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Circle
  def initialize(base, p0)
    @base = base
    @p0 = p0                                       # 円の中心
    @radius = 64                                   # 円の半径
    @speed = Stylet::Vector.sincos(Stylet::Fee.r0) # 速度ベクトル(0度の方向)
  end

  def update
    # 円を左右に動かす
    @p0 += @speed.scale(@base.button.btA.repeat_0or1) + @speed.scale(-@base.button.btB.repeat_0or1)

    # 円と点の距離が円の半径より小さかったら
    if @p0.distance_to(@base.cursor) < @radius
      # カーソルから円を押し出す
      @p0 = @base.cursor + Stylet::Vector.sincos(@base.cursor.angle_to(@p0)) * @radius
    end
    @base.draw_circle(@p0, :radius => @radius, :vertex => 32)
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << Circle.new(self, half_pos.clone)
    @cursor_radius = 1
  end

  def update
    super if defined? super
    vputs "Z:x++ X:x--"
  end
end

App.main_loop
