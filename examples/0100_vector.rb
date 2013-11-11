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

Vector.one.reverse                             # => [-1.0, -1.0]
-Vector.one                                    # => [-1.0, -1.0]

Vector[3, 4].normalize                         # => [0.6, 0.8]

Vector.one.normalize                           # => [0.7071067811865475, 0.7071067811865475]
Vector.one.magnitude                           # => 1.4142135623730951
Vector.one.magnitude_sq                        # => 2.0

v = Vector.rand
v.round(2)                                     # => [-0.74, -0.81]
v.round                                        # => [-1, -1]
v.floor                                        # => [-1, -1]
v.ceil                                         # => [0, 0]
v.truncate                                     # => [0, 0]

Vector.rand                                    # => [-0.752559755695537, 0.5284796595503249]
Vector.rand(3)                                 # => [1, 0]
Vector.rand(3..4)                              # => [3, 3]
Vector.rand(3.0..4)                            # => [3.95811975270524, 3.6648683176010435]
Vector.rand(-2.0..2.0)                         # => [-1.7726486518600364, 0.2931918847247501]

Vector[1, 0].dot_product(Vector[1, 0])       # => 1
Vector[1, 0].dot_product(Vector[-1, 0])      # => -1

Vector.cross_product(Vector.rand, Vector.rand) # => -0.1998334076625934

Vector.rand.distance_to(Vector.rand)           # => 0.39855432135106394

v = Vector.new
v.object_id                                    # => 70264489302060
v.replace(Vector.rand)                         # => [-0.3095607799255433, -0.26890073513450075]
v.object_id                                    # => 70264489302060

Vector.zero.distance_to(Vector.one)            # => 1.4142135623730951

Vector.zero.zero?                              # => true
Vector.one.nonzero?                            # => true

Vector.zero.inspect                            # => "[0.0, 0.0]"
Vector.zero.to_s                               # => "[0.0, 0.0]"

Vector[1,2].prep                               # => [-2, 1]
