module Stylet
  module DrawSupport
    #
    # draw_polygon(rect.center)
    #
    def draw_polygon(points, options = {})
      options = {
      }.merge(options)

      points.size.times{|i|
        p0 = points[i]
        p1 = points[i.next % points.size]
        draw_line(p0, p1, options)
      }
    end
  end
end

if $0 == __FILE__
  require_relative "../../stylet"
  Stylet::Base.main_loop do |win|
    points = Array.new(3){Stylet::Vector.new(rand(win.rect.w), rand(win.rect.h))}
    win.draw_polygon(points)
  end
end
