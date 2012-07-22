# -*- coding: utf-8 -*-
#
# 円と点の反射
#
require_relative "helper"

class Circle
  def initialize(win)
    @win = win

    @radius = 64                                     # 円の半径

    @pos = Stylet::Vector.new(@win.rect.center.x, @win.rect.max_y)             # 物体初期位置
    @speed = Stylet::Vector.new(Stylet::Etc.wide_rand(2.0), Stylet::Etc.range_rand(-12, -15)) # 速度ベクトル
    @gravity = Stylet::Vector.new(0, 0.220)                                                        # 重力
  end

  def update
    @speed += @gravity
    @pos += @speed

    diff = @pos - @win.cursor
    if diff.length > 0
      if diff.length < @radius
        @pos = @win.cursor + diff.normalize.scale(@radius)
        @speed = diff.normalize * @speed.length
      end
    end

    @win.draw_polygon(@pos, :radius => @radius, :vertex => 32)
    @win.vputs "Z:x++ X:x--"
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << Circle.new(self)
    @cursor_radius = 1
  end
end

App.main_loop
