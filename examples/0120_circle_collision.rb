# -*- coding: utf-8 -*-
#
# 円同士の当り判定
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  def initialize(base, pos)
    @base = base
    @pos = pos
    @radius = 64
  end

  def update
    dx = (@pos.x - @base.mpos.x).abs
    dy = (@pos.y - @base.mpos.y).abs
    distance = Math.sqrt((dx ** 2) + (dy ** 2))
    @base.vputs(distance)
    distance_min = @radius + @base.radius
    if distance < distance_min
      dir = Stylet::Fee.rdirf(@base.mpos.x, @base.mpos.y, @pos.x, @pos.y)
      @pos.x = @base.mpos.x + Stylet::Fee.rcosf(dir) * distance_min
      @pos.y = @base.mpos.y + Stylet::Fee.rsinf(dir) * distance_min
    end
    @base.draw_circle(@pos, :radius => @radius, :vertex => 32)
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :radius

  def before_main_loop
    super if defined? super
    @objects << Ball.new(self, half_pos)
    @radius = 64
  end

  def update
    super if defined? super
    draw_circle(@mpos, :radius => @radius, :vertex => 32)
  end
end

App.main_loop
