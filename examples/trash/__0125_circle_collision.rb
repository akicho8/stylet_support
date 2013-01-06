# -*- coding: utf-8 -*-
#
# 円同士の当り判定
#
require_relative "helper"

class Ball
  def initialize(win, cpos)
    @win = win
    @cpos = cpos
    @pos = @cpos.clone
    @radius = 64
    @vr = 0
    @r = 0
    @dir = 0
  end

  def update
    dx = (@pos.x - @win.mouse_vector.x).abs
    dy = (@pos.y - @win.mouse_vector.y).abs
    distance = Math.sqrt((dx ** 2) + (dy ** 2))
    @win.vputs(distance)
    radius_plus = @radius + @win.radius
    gap = radius_plus - distance
    if gap > 0
      @dir = Stylet::Fee.angle(@win.mouse_vector.x, @win.mouse_vector.y, @pos.x, @pos.y)
      @cpos = @pos.clone
      @r = 0
      @vr = gap
    end
    @vr -= 0.01
    if @vr < 0
      @vr = 0
    end
    @r += @vr
    @pos.x = @cpos.x + Stylet::Fee.cos(@dir) * @r
    @pos.y = @cpos.y + Stylet::Fee.sin(@dir) * @r
    @win.draw_polygon(@pos, :radius => @radius, :vertex => 32)
  end

  def screen_out?
    false
  end
end

module Helper
  module HandCursor
    include Stylet::Input::Base
    include Stylet::Input::StandardKeybord
    include Stylet::Input::JoystickBinding
    include Stylet::Input::MouseButtonAsCounter

    def before_main_loop
      super if defined? super
      @cursor = @mouse_vector.clone
      @cursor_speed = 5
      @objects = []
    end

    def update
      super if defined? super

      if joy = joys.first
        update_by_joy(joy)
      end
      key_counter_update_all

      if mouse_moved?
        @cursor = @mouse_vector.clone
      end

      if dir = axis_angle
        @cursor.x += Stylet::Fee.cos(dir) * @cursor_speed
        @cursor.y += Stylet::Fee.sin(dir) * @cursor_speed
      end

      vputs @mouse_vector.to_a
      vputs mouse_moved?

      vputs @objects.size
      @objects.each{|e|e.update}
      @objects.reject!{|e|e.screen_out?}
      draw_polygon(@cursor, :radius => 16, :vertex => 3, :angle => 1.0 / 64 * @count)
    end
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :radius

  def before_main_loop
    super if defined? super
    @objects << Ball.new(self, rect.center)
    @radius = 64
  end

  def update
    super if defined? super
    draw_polygon(@mouse_vector, :radius => @radius, :vertex => 32)
  end
end

App.main_loop
