require "./setup"
include Stylet

Point.new                                      # => [0.0, 0.0]
Point[1, 2]                                    # => [1, 2]
Point[1, 2].members                            # => [:x, :y]
Point[1, 2].values                             # => [1, 2]
Point[1, 2]                                    # => [1, 2]

Vector.superclass                              # => Stylet::Point2

Point.new(Point[1,2])                          # => [1, 2]
Point[Point[1,2]]                              # => [1, 2]

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

a + [3, 4]                                     # => [4.0, 6.0]
a - [3, 4]                                     # => [-2.0, -2.0]

Vector.one.reverse                             # => [-1.0, -1.0]
-Vector.one                                    # => [-1.0, -1.0]

Vector[3, 4].normalize                         # => [0.6, 0.8]

Vector.one.normalize                           # => [0.7071067811865475, 0.7071067811865475]
Vector.one.magnitude                           # => 1.4142135623730951
Vector.one.magnitude_sq                        # => 2.0

v = Vector.rand
v.round(2)                                     # => [0.38, 0.32]
v.round                                        # => [0, 0]
v.floor                                        # => [0, 0]
v.ceil                                         # => [1, 1]
v.truncate                                     # => [0, 0]

Vector.rand                                    # => [-0.11178572190988056, -0.9579740673291302]
Vector.rand(3)                                 # => [1, 1]
Vector.rand(3..4)                              # => [3, 3]
Vector.rand(3.0..4)                            # => [3.385788174895441, 3.243193721635672]
Vector.rand(-2.0..2.0)                         # => [-0.11462874488152064, -0.5719227925271224]

Vector[1, 0].dot_product(Vector[1, 0])       # => 1
Vector[1, 0].dot_product(Vector[-1, 0])      # => -1

Vector.cross_product(Vector.rand, Vector.rand) # => 0.37415586119802274

Vector.rand.distance_to(Vector.rand)           # => 1.552555114034262

v = Vector.new
v.object_id                                    # => 70181520566780
v.replace(Vector.rand)                         # => [0.9156541157178435, 0.9496087051944213]
v.object_id                                    # => 70181520566780

Vector.zero.distance_to(Vector.one)            # => 1.4142135623730951

Vector.zero.zero?                              # => true
Vector.one.nonzero?                            # => true

Vector.zero.inspect                            # => "[0.0, 0.0]"
Vector.zero.to_s                               # => "[0.0, 0.0]"

Vector[1,2].prep                               # => [-2, 1]
