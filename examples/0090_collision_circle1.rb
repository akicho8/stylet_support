# -*- coding: utf-8 -*-
#
# 円同士の当り判定(従来の方法)
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  def initialize(win, pos)
    @win = win
    @pos = pos
    @radius = 64
  end

  def update
    distance = @pos.distance_to(@win.cursor)
    radius2 = @radius + @win.cursor_radius
    if distance < radius2
      @win.draw_line2(@pos, @win.cursor)
      @win.vputs "COLLISION"

      if @win.button.btA.press?
        # カーソルの方向から円の位置の方向に一方的に移動させる
        dir = @win.cursor.angle_to(@pos)
        @pos.x = @win.cursor.x + Stylet::Fee.cos(dir) * radius2
        @pos.y = @win.cursor.y + Stylet::Fee.sin(dir) * radius2
      end
    end
    @win.draw_circle(@pos, :radius => @radius, :vertex => 32)
    if @win.count.modulo(5) == 0
      @win.draw_line2(@pos, @win.cursor)
    end
    @win.vputs "radius2=#{radius2}"
    @win.vputs "distance=#{distance}"
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << Ball.new(self, srect.center.clone)
    @cursor_radius = 64
    @cursor_vertex = 32
  end
end

App.main_loop
