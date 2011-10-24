$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestCell < Test::Unit::TestCase
  def test_exist?
    obj = Cell.new("b")
    assert(obj.exist?)
    obj.clear!
    assert(!obj.exist?)
  end

  def test_getid
    obj = Cell.new("b")
    assert_equal("b", obj.color)
  end

  def test_color
    obj = Cell.new("b")
    assert_equal("b", obj.color)
  end

  def test_EQ
    assert_equal(false, Cell.new("c")==Cell.new("b"))
    assert_equal( true, Cell.new("c")==Cell.new("c"))
    a = Cell.new("c")
    b = Cell.new("b")
    b.clear!
    assert_equal(false, a==b)
    assert_equal(false, a==nil)
  end

  def test_to_s
    obj = Cell.new("b")
    assert_equal("b", obj.to_s)
    obj.clear!
    assert_equal(".", obj.to_s)
  end
end
