require "./setup"
include Stylet

Point.new                       # => #<struct Stylet::Point x=nil, y=nil>
Point[1, 2]                     # => #<struct Stylet::Point x=1, y=2>
Point[1, 2].members             # => [:x, :y]
Point[1, 2].values              # => [1, 2]
Point[1, 2].to_h                # => {:x=>1, :y=>2}

Vector.superclass               # => Stylet::Point

a = Vector[1, 2]
b = Vector[3, 4]

a + b                         # => #<struct Stylet::Vector x=4.0, y=6.0>
a - b                         # => #<struct Stylet::Vector x=-2.0, y=-2.0>
a * 2                         # => #<struct Stylet::Vector x=2.0, y=4.0>
a / 2                         # => #<struct Stylet::Vector x=0.5, y=1.0>

a.add(b)                      # => #<struct Stylet::Vector x=4.0, y=6.0>
a.sub(b)                      # => #<struct Stylet::Vector x=-2.0, y=-2.0>
a.scale(2)                    # => #<struct Stylet::Vector x=2.0, y=4.0>
a.mul(2)                      # => #<struct Stylet::Vector x=2.0, y=4.0>
a.div(2)                      # => #<struct Stylet::Vector x=0.5, y=1.0>

a.normalize                   # => #<struct Stylet::Vector x=0.4472135954999579, y=0.8944271909999159>
a.normalize.round(2)          # => #<struct Stylet::Vector x=0.45, y=0.89>
