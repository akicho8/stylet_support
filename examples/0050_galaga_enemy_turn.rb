# -*- coding: utf-8 -*-
#
# ギャラガの敵の動き
#
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

class Ball
  def initialize(base, index)
    @base = base
    @index = index
  end

  def update
    pos0 = pos_new(@base.count)
    pos1 = pos_new(@base.count.next)
    dir = Stylet::Fee.rdirf(pos0.x, pos0.y, pos1.x, pos1.y)
    @base.draw_circle(pos0, :radius => 20, :vertex => 3, :offset => dir)
  end

  def pos_new(count)
    pos = Stylet::Point.new
    pos.x = @base.half_x + Stylet::Fee.rcosf(1.0 / 512 * (count * 3 + @index * 24)) * @base.half_x
    pos.y = @base.half_y + Stylet::Fee.rsinf(1.0 / 512 * (count * 4 + @index * 24)) * @base.half_y
    pos
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
