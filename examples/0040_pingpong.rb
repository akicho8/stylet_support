# -*- coding: utf-8 -*-
# sin/cosのデモ
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

class Ball
  def initialize(base, index)
    @base = base
    @index = index
  end

  def update
    pos = Stylet::Point.new
    pos.x = @base.half_x + Stylet::Fee.rcosf(1.0 / 512 * (@base.count * 3 + @index * 24)) * @base.half_x
    pos.y = @base.half_y + Stylet::Fee.rsinf(1.0 / 512 * (@base.count * 4 + @index * 24)) * @base.half_y
    @base.draw_circle(pos, :radius => 20, :vertex => 3, :offset => 1.0 / 256 * (@base.count + @index * 16))
  end
end

class App < Stylet::Base
  def before_main_loop
    super
    @objects = Array.new(8){|i|Ball.new(self, i)}
  end

  def update
    super
    @objects.each{|e|e.update}
  end
end

App.main_loop
