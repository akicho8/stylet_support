# -*- coding: utf-8 -*-
# sin/cosのデモ
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

class Ball
  def initialize(base, position)
    @base = base
    @radius = 16
    @offset = 1.0 / 256 * position * 24
  end

  def update
    @x = @base.half_x + Stylet::Fee.rcosf(@offset + 0.001 * 7 * @base.count) * @base.half_x
    @y = @base.half_y + Stylet::Fee.rsinf(@offset + 0.001 * 8 * @base.count) * @base.half_y
    @base.fill_rect(@x - @radius, @y - @radius, @radius * 2, @radius * 2, "white")
  end
end

class App < Stylet::Base
  def before_main_loop
    super
    @balls = Array.new(8){|i|Ball.new(self, i)}
  end

  def update
    super
    @balls.each{|e|e.update}
  end
end

App.main_loop
