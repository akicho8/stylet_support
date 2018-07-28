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
v.round(2)                                     # => [0.48, 0.6]
v.round                                        # => [0, 1]
v.floor                                        # => [0, 0]
v.ceil                                         # => [1, 1]
v.truncate                                     # => [0, 0]

Vector.rand                                    # => [0.37182089855094613, -0.99052832152511]
Vector.rand(3)                                 # => [1, 1]
Vector.rand(3..4)                              # => [4, 4]
Vector.rand(3.0..4)                            # => [3.655724436092496, 3.3356907533135023]
Vector.rand(-2.0..2.0)                         # => [-0.6592404423144278, 1.5211933133588427]

Vector[1, 0].dot_product(Vector[1, 0])         # => 1
Vector[1, 0].dot_product(Vector[-1, 0])        # => -1

Vector.cross_product(Vector.rand, Vector.rand) # => 0.7501561461552074

Vector.rand.distance_to(Vector.rand)           # => 0.7463133439748652

v = Vector.new
v.object_id                                    # => 70119757980160
v.replace(Vector.rand)                         # => [0.29626268422451485, 0.8924141847532647]
v.object_id                                    # => 70119757980160

Vector.zero.distance_to(Vector.one)            # => 1.4142135623730951

Vector.zero.zero?                              # => true
Vector.one.nonzero?                            # => true

Vector.zero.inspect                            # => "[0.0, 0.0]"
Vector.zero.to_s                               # => "[0.0, 0.0]"

Vector[1, 2].prep                               # => [-2, 1]
