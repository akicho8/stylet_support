# -*- coding: utf-8 -*-
module Stylet
  module DrawSupport
    #
    # draw_circle(half_pos)
    #
    def draw_circle(p0, options = {})
      options = {
        :radius => 64,
        :vertex => 8,
        :color => "white",
        :fill => false,
        :angle => Fee.r270,      # 開始地点
      }.merge(options)

      points = (0...options[:vertex]).collect{|i|
        a = options[:angle] + (1.0 / options[:vertex]) * i
        p0 + Vector.sincos(a) * options[:radius]
      }
      draw_polygon(points, options)
    end

    #
    # 三角形の表示
    #
    def draw_triangle(p0, options = {})
      options = {
        :vertex => 3,
      }.merge(options)
      draw_circle(p0, options)
    end

    #
    # 正方形の表示
    #
    def draw_square(p0, options = {})
      options = {
        :vertex => 4,
      }.merge(options)
      draw_circle(p0, options)
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../../stylet"))
  Stylet::Base.main_loop do |win|
    win.draw_circle(win.half_pos)
  end
end
