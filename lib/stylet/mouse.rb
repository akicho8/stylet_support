# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "vector"))

module Stylet
  module Mouse
    attr_reader :mouse_btA, :mouse_btB, :mouse_btC
    attr_reader :mpos, :before_mpos, :start_mpos, :__mouse_vector, :mlonglength, :mouse_move_count, :mouse_dir

    def initialize(*)
      super if defined? super
      @mpos = Vector.new(0, 0)
      @before_mpos = @mpos.clone
      @start_mpos = nil
      @mouse_move_count = 0
    end

    def polling
      super if defined? super
      @before_mpos = @mpos.clone
      @mpos.x, @mpos.y, @mouse_btA, @mouse_btB, @mouse_btC = SDL::Mouse.state
      if mouse_moved?
        if @mouse_move_count == 0
          @start_mpos = @before_mpos.clone
        end
        @__mouse_vector = @before_mpos.distance(@mpos)
        @mlonglength = @start_mpos.distance(@mpos)
        @mouse_dir = Stylet::Fee.angle(@before_mpos.x, @before_mpos.y, @mpos.x, @mpos.y)
        @mouse_move_count += 1
      else
        @__mouse_vector = nil
        @mlonglength = nil
        @mouse_move_count = 0
      end
    end

    def mouse_moved?
      @before_mpos != @mpos
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../stylet"))
  Stylet::Base.main_loop do |base|
    base.vputs "start_mpos: #{base.start_mpos.to_a.inspect}"
    base.vputs "before_mpos: #{base.before_mpos.to_a.inspect}"
    base.vputs "mpos: #{base.mpos.to_a.inspect}"
    base.vputs "__mouse_vector: #{base.__mouse_vector}"
    base.vputs "mlonglength: #{base.mlonglength}"
    base.vputs "mouse_move_count: #{base.mouse_move_count}"
  end
end
