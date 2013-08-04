# -*- coding: utf-8 -*-
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/class/attribute_accessors'
require_relative "vector"

module Stylet
  module Mouse
    attr_reader :mouse

    def initialize
      super
      @mouse = Info.new
    end

    def polling
      super
      @mouse.update { SDL::Mouse.state }
    end

    # moved?        移動した？
    # point         現在座標
    # button        ボタンの状態
    # vector        移動ベクトル
    # vector.angle  移動方向
    # vector.length 移動距離
    class Info
      cattr_accessor(:sensitivity) { 3 }

      attr_accessor :button, :point, :vector

      def initialize
        @button      = Struct.new(:a, :b, :c).new
        @point       = Vector.new(0, 0)
        @history     = []
      end

      def update
        @before_pt = @point.dup
        @point.x, @point.y, @button.a, @button.b, @button.c = yield
        @history = ([@point.dup] + @history).take(sensitivity)
        @vector = @point - @history.last
      end

      def moved?
        @before_pt != @point
      end

      def to_s
        [@point.to_a, @button.values, @vector.to_a].inspect
      end
    end
  end
end

if $0 == __FILE__
  require_relative "../stylet"
  Stylet.app do
    vputs "mouse: #{mouse}"
    draw_vector(mouse.vector, :origin => rect.center, :label => mouse.vector.length)
  end
end
