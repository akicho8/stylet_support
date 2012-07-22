# -*- coding: utf-8 -*-
module Stylet
  module DrawSupport
    #
    # 多角形の描画
    #
    def draw_polygon(p0, options = {})
      options = {
        :radius => 64,       # 半径
        :vertex => 8,        # n角形
        :angle  => Fee.r270, # 開始地点
      }.merge(options)

      raise "options[:vertex] is not Integer" unless options[:vertex].kind_of? Integer
      raise "options[:vertex] >= 1" if options[:vertex].to_i.zero?
      raise "zero vector" if options[:vertex].zero?

      points = options[:vertex].times.collect{|i|
        a = options[:angle] + 1.0 * i / options[:vertex]
        p0 + Vector.angle_at(a) * options[:radius]
      }
      draw_polygon(points, options)
    end

    #
    # 三角形の描画
    #
    def draw_triangle(p0, options = {})
      draw_polygon(p0, {:vertex => 3}.merge(options))
    end

    #
    # 正方形の描画
    #
    def draw_square(p0, options = {})
      draw_polygon(p0, {:vertex => 4}.merge(options))
    end
  end
end

if $0 == __FILE__
  require_relative "../../stylet"
  Stylet::Base.main_loop do |win|
    win.draw_polygon(win.rect.center)
    # win.draw_triangle(win.rect.center)
    # win.draw_square(win.rect.center)
  end
end
