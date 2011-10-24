$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestKeyOne < Test::Unit::TestCase
  def test_repeat
    obj = KeyOne.new("?")
    cnt_ary, rep_ary = [], []
    6.times {
      obj.update(true)
      rep_ary << obj.repeat(3)
      cnt_ary << obj.count
    }
    assert_equal([1, 0, 0, 0, 2, 3], rep_ary)
    assert_equal([1, 2, 3, 4, 5, 6], cnt_ary)
  end

  def test_EQ
    a = KeyOne.new
    b = KeyOne.new
    assert_equal(true, a == b)
    b.update(true)
    assert_equal(true, a != b)
  end

  def test_EQ_for_sort
    a = KeyOne.new
    b = KeyOne.new
    assert_equal(0, a <=> b)    # 0, 0
    b.update(true)
    assert_equal(+1, a <=> b)   # 0, 1
    a.update(true)
    b.update(true)
    assert_equal(-1, a <=> b)   # 1, 2
  end

  def test_ARROR_LL
    a = KeyOne.new
    a << (true | false)
    a.update
    assert_equal(1, a.count)
  end
end
