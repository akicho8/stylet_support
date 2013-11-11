require "./setup"
include Stylet

Point.new                                      # => [nil, nil]
Point[1, 2]                                    # => [1, 2]
Point[1, 2].members                            # => [:x, :y]
Point[1, 2].values                             # => [1, 2]
Point[1, 2]                                    # => [1, 2]

Vector.superclass                              # => Stylet::Point2

Point.new(Point[1,2])                           # => [1, 2]
Point[Point[1,2]]                               # => [1, 2]

Vector.new                                     # => [0.0, 0.0]
Vector.new                                     # => [0.0, 0.0]
Vector.new(1, 2)                               # => [1, 2]

Vector.zero                                    # => [0.0, 0.0]
Vector.one                                     # => [1.0, 1.0]

a = Vector[1, 2]
b = Vector[3, 4]

a + b                                          # => [4.0, 6.0]
a - b                                          # => [-2.0, -2.0]
a * 2                                          # => [2.0, 4.0]
a / 2                                          # => [0.5, 1.0]

a.add(b)                                       # => [4.0, 6.0]
a.sub(b)                                       # => [-2.0, -2.0]
a.scale(2)                                     # => [2.0, 4.0]
a.mul(2)                                       # => [2.0, 4.0]
a.div(2)                                       # => [0.5, 1.0]

Vector.one.reverse                             # => [-1.0, -1.0]
-Vector.one                                    # => [-1.0, -1.0]

Vector[3, 4].normalize                         # => [0.6, 0.8]

Vector.one.normalize                           # => [0.7071067811865475, 0.7071067811865475]
Vector.one.magnitude                           # => 1.4142135623730951
Vector.one.magnitude_sq                        # => 2.0

v = Vector.rand
v.round(2)                                     # => [-0.56, -0.82]
v.round                                        # => [-1, -1]
v.floor                                        # => [-1, -1]
v.ceil                                         # => [0, 0]
v.truncate                                     # => [0, 0]

Vector.rand                                    # => [0.4057461799806972, -0.23808777625156985]
Vector.rand(3)                                 # => [2, 0]
Vector.rand(3..4)                              # => [3, 4]
Vector.rand(3.0..4)                            # => [3.2469139804642415, 3.4657455075471137]
Vector.rand(-2.0..2.0)                         # => [1.455803890592764, 0.7724963281586659]

Vector[1, 0].inner_product(Vector[1, 0])       # => 1
Vector[1, 0].inner_product(Vector[-1, 0])      # => -1

Vector.cross_product(Vector.rand, Vector.rand) # => -0.10275400781516983

Vector.rand.distance_to(Vector.rand)           # => 2.275368849486666

v = Vector.new
v.object_id                                    # => 70242182689180
v.replace(Vector.rand)              # => [-0.07634952958262664, -0.1731985596574761]
v.object_id                                    # => 70242182689180

Vector.zero.distance_to(Vector.one)            # => 1.4142135623730951

Vector.zero.zero?                              # => true
Vector.one.nonzero?                            # => true

Vector.zero.inspect                            # => "[0.0, 0.0]"
Vector.zero.to_s                               # => "[0.0, 0.0]"
