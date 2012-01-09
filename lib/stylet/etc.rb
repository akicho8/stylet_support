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

    def range_rand(a, b)
      a + rand * (b - a)
    end

    def wide_rand(r)
      rand * (r * 2) - r
    end

    # -1.0 と +1.0 だけでランダム
    # 円が完全に衝突したとき用
    def nonzero_random
      rand(2).zero? ? 1.0 : -1.0
    end
  end
end


if $0 == __FILE__
  p Stylet::Etc.range_limited(0.5)
  p Stylet::Etc.upper_limited(1.5)
  p Stylet::Etc.lower_limited(-0.5)
end

