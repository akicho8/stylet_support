# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  def initialize(base, s, v, a)
    @base = base
    @s = s
    @v = v
    @a = a
    # x_wide = 0.8
    # x = rand(x_wide) - x_wide / 2
    # @a = Stylet::Point.new(0, -rand(0.1))
  end

  def update
    @v.x += @a.x
    @v.y += @a.y
    @s.x += @v.x
    @s.y += @v.y
    @base.draw_circle(@s, :radius => 16, :vertex => 3, :offset => 1.0 / 64 * @base.count)
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
      @objects << Ball.new(self, @cursor.clone, Stylet::Point.new(0, -12), Stylet::Point.new(0, 0.2))
    end
  end
end

App.main_loop
