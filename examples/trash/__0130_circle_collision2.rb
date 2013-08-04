# -*- coding: utf-8 -*-
#
# 円同士の当り判定
#
require_relative "helper"

class Ball
  def initialize(win, cpos)
    @win = win
    @cpos = cpos
    @radius = 64
    @r = 0
    @vr = 4.0
    @ar = -0.01
    @dir = 0.0
  end

  def update
    @win.objects.each{|object|
      next if object == self

      dx = (@pos.x - object.pos.x).abs
      dy = (@pos.y - object.pos.y).abs
      distance = Math.sqrt((dx ** 2) + (dy ** 2))
      @win.vputs(distance)
      distance_min = @radius + @win.radius
      if distance < distance_min
        dir = Stylet::Fee.angle(object.pos.x, object.pos.y, @pos.x, @pos.y)
        @pos.x = object.pos.x + Stylet::Fee.cos(dir) * distance_min
        @pos.y = object.pos.y + Stylet::Fee.sin(dir) * distance_min
      end
    }
    @pos.x += Stylet::Fee.cos(@dir) * @r
    @pos.y += Stylet::Fee.sin(@dir) * @r
    @win.draw_polygon(@pos, :radius => @radius, :vertex => 32)
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :objects

  def before_main_loop
    super if defined? super
    4.times{
      @objects << Ball.new(self, rect.center)
    }
  end

  def update
    super if defined? super
    if object = @objects.first
      object.pos = @mouse.point.clone
    end
  end
end

App.main_loop
