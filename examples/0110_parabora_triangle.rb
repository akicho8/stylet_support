# -*- coding: utf-8 -*-
#
# マウスの位置からZボタンで放物線を描く三角を表示
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  def initialize(base, p, v, a)
    @base = base
    @p = p
    @v = v
    @a = a
  end

  def update
    @v += @a
    @p += @v
    @base.draw_circle(@p, :radius => 16, :vertex => 3, :offset => 1.0 / 64 * @base.count)
  end

  def screen_out?
    @v.y > 0 && @s.y > @base.max_y
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def update
    super if defined? super
    if @button.btA.count.modulo(4) == 1
      @objects << Ball.new(self, @cursor.clone, Stylet::Vector.new(0, -12), Stylet::Vector.new(0, 0.2))
    end
  end
end

App.main_loop
