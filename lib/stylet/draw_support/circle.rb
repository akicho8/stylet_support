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
        :offset => 0,
      }.merge(options)

      points = (0...options[:vertex]).collect{|i|
        dir = (1.0 / options[:vertex]) * i
        Point.new(
          p0.x + Fee.rcosf(options[:offset] + dir) * options[:radius],
          p0.y + Fee.rsinf(options[:offset] + dir) * options[:radius]
          )
      }
      draw_polygon(points, options)
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../../stylet"))
  Stylet::Base.main_loop do |win|
    win.draw_circle(win.half_pos)
  end
end
