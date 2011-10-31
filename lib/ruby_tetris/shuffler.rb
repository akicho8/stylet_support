module Shuffler
  module_function

  def shuffle_by(ary, rand_obj)
    ary.size.downto(2) do |i|
      r = rand_obj.get_next(ary.size)
      ary[i-1], ary[r] = ary[r], ary[i-1]
    end
    ary
  end
end
