# -*- coding: utf-8 -*-

require 'active_support/core_ext/module/delegation'
require "active_support/core_ext/class/attribute_accessors"
require "active_support/core_ext/string/inflections"

module Stylet
  class JoystickAdapter
    cattr_accessor(:adapters) do
      {
        "USB Gamepad"                => :elecom_usb_pad,
        "PLAYSTATION(R)3 Controller" => :arashi,
      }
    end

    def self.create(object)
      name = SDL::Joystick.index_name(object.index).strip
      Stylet.logger.info [object.index, name].inspect if Stylet.logger
      adapter = "#{adapters[name]}_adapter"
      require_relative "joystick_adapters/#{adapter}"
      "stylet/#{adapter}".classify.constantize.new(object)
    end

    attr_reader :object

    delegate :index, :to => :object

    private_class_method :new

    def initialize(object)
      @object = object
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

    def button_str
      @object.num_buttons.times.collect{|index|
        if @object.button(index)
          index
        end
      }.join
    end

    def axis_str
      [:up, :down, :right, :left].collect{|dir|
        if lever_on?(dir)
          dir.to_s.slice(/^(.)/).upcase
        end
      }.join
    end

    def inspect
      "#{@object.index}: #{name.slice(/^.{8}/)} #{unit_str}"
    end

    def unit_str
      "AXIS:#{axis_str} BTN:#{button_str} %+04d %+04d" % [@object.axis(h_axis_index), @object.axis(v_axis_index)]
    end
  end
end

if $0 == __FILE__
  require_relative "../stylet"
  Stylet.run
end
