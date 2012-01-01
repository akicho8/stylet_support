# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

module Helper
  module SpaceObject
    def initialize(base, *)
      @base = base
      @count = 0
    end

    def screen_out?
      false
    end

    def before_update
    end

    def update
    end

    def after_update
      @count += 1
    end
  end

  module TriangleCursor
    include Stylet::Input::Base
    include Stylet::Input::StandardKeybord
    include Stylet::Input::JoystickBinding
    include Stylet::Input::MouseButtonAsCounter

    attr_reader :cursor, :cursor_radius, :cursor_vertex, :objects

    def before_main_loop
      super if defined? super
      @cursor = @mpos.clone
      @cursor_speed = 5
      @cursor_vertex = 3
      @cursor_radius = 16
      @cursor_display = true
      @objects = []
    end

    def update
      super if defined? super

      if joy = joys.first
        update_by_joy(joy)
      end
      key_counter_update_all

      if mouse_moved?
        @cursor = @mpos.clone
      end

      if dir = axis_angle
        @cursor.x += Stylet::Fee.cos(dir) * @cursor_speed
        @cursor.y += Stylet::Fee.sin(dir) * @cursor_speed
      end

      # vputs @mpos.to_a
      # vputs mouse_moved?

      vputs "objects=#{@objects.size}"
      @objects.each{|e|e.update}
      @objects.reject!{|e|e.screen_out?}
      if @cursor_display
        draw_circle(@cursor, :radius => @cursor_radius, :vertex => @cursor_vertex, :offset => 1.0 / 64 * @count)
      end
    end
  end
end
