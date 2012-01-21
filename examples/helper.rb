# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

# Stylet::Conf.update({
#     # :screen_size      => [640, 480],
#     # :screen_size      => [800, 600],
#     # :color_depth      => 8,
#   })

# Stylet::Palette.update({
#     "background" => [255, 255, 255],
#     "foreground" => [0, 0, 0],
#   })

# Stylet::Palette.update({
#     "background" => [0, 8*12, 0],
#     "foreground" => [0, 8*31, 0],
#   })

module Helper
  module SpaceObject
    def initialize(win, *)
      @win = win
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
      @cursor = @mouse_vector.clone
      @cursor_speed = 5
      @cursor_vertex = 3
      @cursor_radius = 8
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
        @cursor = @mouse_vector.clone
      end

      if dir = axis_angle
        @cursor += Stylet::Vector.angle_at(dir) * @cursor_speed
      end

      # vputs @mouse_vector.to_a
      # vputs mouse_moved?

      # unless @objects.empty?
      #   vputs "objects=#{@objects.size}"
      # end

      @objects.each{|e|e.update}
      @objects.reject!{|e| e.respond_to?(:screen_out?) && e.screen_out?}

      if @cursor_display
        draw_circle(@cursor, :radius => @cursor_radius, :vertex => @cursor_vertex, :angle => 1.0 / 64 * @count)
      end
    end
  end
end
