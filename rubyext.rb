#!/usr/local/bin/ruby -Ku

# 消したい
class Array
  def unflatten(n)
    array = []
    0.step(size-n, n){|i|
      array << self[i,n]
    }
    if (size % n) != 0
      array << self[size / n * n, size % n]
    end
    array
  end
end

# p [1,2,3,4,5,6,7,8,9,10].unflatten(3) #=> [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]
# p [1,2,3,4,5,6,7,8,9,10].unflatten(1) #=> [[1], [2], [3], [4], [5], [6], [7], [8], [9], [10]]

if $0 == __FILE__
end
