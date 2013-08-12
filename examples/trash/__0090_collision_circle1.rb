# -*- coding: utf-8 -*-
#
# 円同士の当り判定(従来の方法)
#
require_relative "helper"

class Ball
  def initialize(win, pos)
    @win = win
    @pos = pos
    @radius = 64
  end

  def update
    distance = @pos.distance_to(@win.cursor.point)
    radius2 = @radius + @win.cursor.radius
    if distance < radius2
      @win.draw_line(@pos, @win.cursor.point)
      @win.vputs "COLLISION"

      if @win.button.btA.press?
        # カーソルの方向から円の位置の方向に一方的に移動させる
        dir = @win.cursor.point.angle_to(@pos)
        @pos.x = @win.cursor.point.x + Stylet::Fee.cos(dir) * radius2
        @pos.y = @win.cursor.point.y + Stylet::Fee.sin(dir) * radius2
      end
    end
    @win.draw_polygon(@pos, :radius => @radius, :vertex => 32)
    if @win.count.modulo(5) == 0
      @win.draw_line(@pos, @win.cursor.point)
    end
    @win.vputs "radius2=#{radius2}"
    @win.vputs "distance=#{distance}"
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::CursorWithObjectCollection

  def before_run
    super if defined? super
    @objects << Ball.new(self, rect.center.clone)
    @cursor.radius = 64
    @cursor.vertex = 32
  end
end

App.run
