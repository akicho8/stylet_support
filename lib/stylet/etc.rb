# -*- coding: utf-8 -*-
module Stylet
  module Etc
    extend self

    def range_limited(v, range = (0.0..1.0))
      v = lower_limited(v, range.begin)
      v = upper_limited(v, range.end)
    end

    def upper_limited(v, r = 1.0)
      [v, r].min
    end

    def lower_limited(v, r = 0.0)
      [v, r].max
    end

    def abs_limited(v, r = 1.0)
      range_limited(v, (-r..r))
    end
  end
end


if $0 == __FILE__
  p Stylet::Etc.range_limited(0.5)
  p Stylet::Etc.upper_limited(1.5)
  p Stylet::Etc.lower_limited(-0.5)
end

