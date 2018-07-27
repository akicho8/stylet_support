module Stylet
  module Chore
    extend self

    def clamp(v, range = (0.0..1.0))
      v.clamp(range.min, range.max)
    end

    def max_clamp(v, r = 1.0)
      [v, r].min
    end

    def min_clamp(v, r = 0.0)
      [v, r].max
    end

    def abs_clamp(v, r = 1.0)
      clamp(v, (-r..r))
    end

    # b から a へ行きたいときの最短の角度差
    def shortest_angular_difference(a, b)
      d = a.modulo(1.0) - b.modulo(1.0)
      if d < -1.0 / 2
        d = 1.0 + d
      elsif d > 1.0 / 2
        d = -1.0 + d
      end
      d
    end
  end
end

if $0 == __FILE__
  Stylet::Chore.clamp(0.5)                            # => 0.5
  Stylet::Chore.max_clamp(1.5)                        # => 1.0
  Stylet::Chore.min_clamp(-0.5)                       # => 0.0
  Stylet::Chore.shortest_angular_difference(0.2, 0.5) # => -0.3
  Stylet::Chore.shortest_angular_difference(0.8, 1.2) # => -0.3999999999999999
end
