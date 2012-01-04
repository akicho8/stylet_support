# -*- coding: utf-8 -*-
module Stylet
  module DrawSupport
    #
    # draw_circle(srect.half_pos)
    #
    def draw_circle(p0, options = {})
      options = {
        :radius => 64,
        :vertex => 8,
        :angle => Fee.r270,      # 開始地点
      }.merge(options)

      raise "options[:vertex] is not Integer" unless options[:vertex].kind_of? Integer
      raise "options[:vertex] >= 1" if options[:vertex].to_i.zero?
      raise if options[:vertex].zero?

      points = (0...options[:vertex]).collect{|i|
        a = options[:angle] + 1.0 * i / options[:vertex]
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
    win.draw_circle(win.srect.half_pos)
  end
end
