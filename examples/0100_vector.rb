require "./setup"
include StyletMath

v1 = Vector.new(1, 2)
v2 = Vector.new(3, 4)
v1 + v2                         # => #<struct StyletMath::Vector x=4.0, y=6.0>
v1 - v2                         # => #<struct StyletMath::Vector x=-2.0, y=-2.0>
v1 * 2                          # => #<struct StyletMath::Vector x=2.0, y=4.0>
v1 / 2                          # => #<struct StyletMath::Vector x=0.5, y=1.0>
v1.normalize                    # => #<struct StyletMath::Vector x=0.4472135954999579, y=0.8944271909999159>
