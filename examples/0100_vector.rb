require "./setup"
include Stylet

Point.new                                      # => [0.0, 0.0]
Point.new(1, 2)                                # => [1, 2]
Point[1, 2]                                    # => [1, 2]
Point[1, 2].members                            # => [:x, :y]
Point[1, 2].values                             # => [1, 2]
Point[1, 2]                                    # => [1, 2]

Point[1, 2] == Point[1, 2]                     # => true
Point[1, 2] == Point[3, 4]                     # => false

Vector.superclass                              # => Stylet::Point2

Point.new(Point[1, 2])                          # => [1, 2]
Point[Point[1, 2]]                              # => [1, 2]

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
v.round(2)                                     # => [0.43, -0.67]
v.round                                        # => [0, -1]
v.floor                                        # => [0, -1]
v.ceil                                         # => [1, 0]
v.truncate                                     # => [0, 0]

Vector.rand                                    # => [0.027598455159824287, 0.9466665069456346]
Vector.rand(3)                                 # => [1, 0]
Vector.rand(3..4)                              # => [3, 4]
Vector.rand(3.0..4)                            # => [3.669585740668192, 3.589649250443759]
Vector.rand(-2.0..2.0)                         # => [-1.4230576557117716, -1.9603063904239009]

Vector[1, 0].dot_product(Vector[1, 0])         # => 1
Vector[1, 0].dot_product(Vector[-1, 0])        # => -1

Vector.cross_product(Vector.rand, Vector.rand) # => -0.1295748222276886

Vector.rand.distance_to(Vector.rand)           # => 0.8561579315374162

v = Vector.new
v.object_id                                    # => 70188854813020
v.replace(Vector.rand)                         # => [0.18741194413180828, -0.7670036741876567]
v.object_id                                    # => 70188854813020

Vector.zero.distance_to(Vector.one)            # => 1.4142135623730951

Vector.zero.zero?                              # => true
Vector.one.nonzero?                            # => true

Vector.zero.inspect                            # => "[0.0, 0.0]"
Vector.zero.to_s                               # => "[0.0, 0.0]"

Vector[1, 2].prep                               # => [-2, 1]
