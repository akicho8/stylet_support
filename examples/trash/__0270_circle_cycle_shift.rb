# -*- coding: utf-8 -*-
#
# 円の動き
#
require_relative "helper"

class Ball
  def initialize(win)
    @win = win
  end

  def update
    pos = Stylet::Vector.new(0, 0)
    pos.x = Stylet::Fee.cos(1.0 / 512 * (@win.count * 3)) * @win.rect.w / 2
    pos.y = Stylet::Fee.sin(1.0 / 512 * (@win.count * 4)) * @win.rect.h / 2
    pos += @win.rect.center
    @win.draw_polygon(pos, :radius => 64)
  end
end

class App < Stylet::Base
  include Helper::CursorWithObjectCollection

  def before_main_loop
    super if defined? super
    @cursor.display = false
    @objects << Ball.new(self)
  end
end

App.main_loop
