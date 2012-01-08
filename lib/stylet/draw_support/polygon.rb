module Stylet
  module DrawSupport
    #
    # draw_polygon(srect.center)
    #
    def draw_polygon(points, options = {})
      options = {
      }.merge(options)

      points.size.times{|i|
        p0 = points[i]
        p1 = points[i.next % points.size]
        draw_line2(p0, p1, options)
      }
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../../stylet"))
  Stylet::Base.main_loop do |win|
    points = Array.new(3){Stylet::Vector.new(rand(win.srect.w), rand(win.srect.h))}
    win.draw_polygon(points)
  end
end
