# -*- coding: utf-8 -*-

require "active_support/core_ext/string/inflections"

module Stylet
  class JoystickAdapter
    def self.create(object)
      adapters = {
        "USB Gamepad"                => "elecom_usb_pad",
        "PLAYSTATION(R)3 Controller" => "arashi",
      }
      joystick_name = SDL::Joystick.index_name(object.index).strip
      p [object.index, joystick_name]
      driver_name = "#{adapters[joystick_name]}_adapter"
      require_relative "joystick_adapters/#{driver_name}"
      "Stylet::#{driver_name.classify}".constantize.new(object)
    end

    attr_reader :object

    def initialize(object)
      @object = object
    end

    def index
      @object.index
    end

    def name
      SDL::Joystick.index_name(index)
    end

    def button(n)
      @object.button(n)
    end

    def h_axis_index
      0
    end

    def v_axis_index
      1
    end

    def lever_on?(dir)
      case dir
      when :up
        @object.axis(v_axis_index) == -32768
      when :down
        @object.axis(v_axis_index) == +32767
      when :right
        @object.axis(h_axis_index) == +32767
      when :left
        @object.axis(h_axis_index) == -32768
      else
        false
      end
    end

    # def axis_angle_index
    #   dir = nil
    #   if lever_on?(:up)
    #     if lever_on?(:right)
    #       dir = 7
    #     elsif lever_on?(:left)
    #       dir = 5
    #     else
    #       dir = 6
    #     end
    #   elsif lever_on?(:down)
    #     if lever_on?(:right)
    #       dir = 1
    #     elsif lever_on?(:left)
    #       dir = 3
    #     else
    #       dir = 2
    #     end
    #   elsif lever_on?(:right)
    #     dir = 0
    #   elsif lever_on?(:left)
    #     dir = 4
    #   end
    #   dir
    # end
    # 
    # def axis_angle
    #   if dir = axis_angle_index
    #     1.0 / 8 * dir
    #   end
    # end

    def button_str
      @object.num_buttons.times.collect{|index|
        if @object.button(index)
          "#{index}"
        end
      }.join
    end

    def axis_str
      [:up, :down, :right, :left].collect{|dir|
        if lever_on?(dir)
          dir.to_s.slice(/^(.)/)
        end
      }.join
    end

    def inspect_str
      "#{@object.index}: #{name.slice(/^.{8}/)} #{unit_str}"
    end

    def unit_str
      "AXIS:#{axis_str} BTN:#{button_str} %+04d %+04d" % [@object.axis(h_axis_index), @object.axis(v_axis_index)]
    end
  end
end

if $0 == __FILE__
  require_relative "../stylet"
  Stylet::Base.main_loop
end
