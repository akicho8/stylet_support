# -*- coding: utf-8 -*-
#
# マウスの位置からZボタンで放物線を描く三角を表示
#
require_relative "helper"

class Ball
  def initialize(win, p0, speed, friction)
    @win = win
    @p0 = p0
    @speed = speed
    @friction = friction
    @radius = 16
  end

  def update
    @speed += @friction
    @p0 += @speed
    @win.draw_triangle(@p0, :radius => @radius, :angle => 1.0 / 64 * @win.count)
  end

  def screen_out?
    @speed.y > 0 && @p0.y > (@win.rect.max_y + @radius)
  end
end

class App < Stylet::Base
  include Helper::CursorWithObjectCollection

  def update
    super if defined? super
    if @button.btA.count.modulo(4) == 1
      @objects << Ball.new(self, @cursor.point.clone, Stylet::Vector.new(0, -12), Stylet::Vector.new(0, 0.2))
    end
  end
end

App.run
