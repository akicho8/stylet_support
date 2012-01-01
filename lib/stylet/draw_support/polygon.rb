module Stylet
  module DrawSupport
    #
    # draw_polygon(half_pos)
    #
    def draw_polygon(points, options = {})
      options = {
        :color => "white",
      }.merge(options)

      points.size.times{|i|
        p0 = points[i]
        p1 = points[i.next % points.size]
        draw_line(p0.x, p0.y, p1.x, p1.y, options[:color])
      }
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../../stylet"))
  Stylet::Base.main_loop do |win|
    points = Array.new(3){Stylet::Vector.new(rand(win.width), rand(win.height))}
    win.draw_polygon(points)
  end
end
