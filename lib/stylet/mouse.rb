# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "vector"))

module Stylet
  module Mouse
    attr_reader :mouse_btA, :mouse_btB, :mouse_btC
    attr_reader :mouse_vector, :__mouse_before_distance, :mouse_angle

    def initialize(*)
      super if defined? super
      @mouse_vector = Vector.new(0, 0)
      @before_mouse_vector = @mouse_vector.clone
      @start_mouse_vector = nil
      @mouse_move_count = 0
    end

    def polling
      super if defined? super
      @before_mouse_vector = @mouse_vector.clone
      @mouse_vector.x, @mouse_vector.y, @mouse_btA, @mouse_btB, @mouse_btC = SDL::Mouse.state
      if mouse_moved?
        if @mouse_move_count == 0
          @start_mouse_vector = @before_mouse_vector.clone
        end
        @__mouse_before_distance = @before_mouse_vector.distance_to(@mouse_vector)
        @mlonglength = @start_mouse_vector.distance_to(@mouse_vector)
        @mouse_angle = @before_mouse_vector.angle_to(@mouse_vector) # 直前からなのでかなり精度が低いので注意
        @mouse_move_count += 1
      else
        @__mouse_before_distance = nil
        @mlonglength = nil
        @mouse_move_count = 0
      end
    end

    def mouse_moved?
      @before_mouse_vector != @mouse_vector
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../stylet"))
  Stylet::Base.main_loop do |win|
    win.vputs "start_mouse_vector: #{win.start_mouse_vector.to_a.inspect}"
    win.vputs "before_mouse_vector: #{win.before_mouse_vector.to_a.inspect}"
    win.vputs "mouse_vector: #{win.mouse_vector.to_a.inspect}"
    win.vputs "__mouse_before_distance: #{win.__mouse_before_distance}"
    win.vputs "mlonglength: #{win.mlonglength}"
    win.vputs "mouse_move_count: #{win.mouse_move_count}"
  end
end
