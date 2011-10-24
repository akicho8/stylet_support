$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestTextKeyUnit < Test::Unit::TestCase
  def test_new
    obj = TextInputUnit.new(["udlrABCD", "", "ud"])

    obj.next_frame
    assert_equal("udABCD", obj.to_s) # UDがあるとLRが無効になる

    obj.next_frame
    assert_equal("", obj.to_s)

    obj.next_frame
    assert_equal("ud", obj.to_s)

    assert_equal(["udABCD", "", "ud"], obj.history)
  end

  def test_new2
    obj = TextInputUnit.new("A B C")
    3.times{obj.next_frame}
    assert_equal(["A", "B", "C"], obj.history)
  end

  def test_new3
   obj = TextInputUnit.new([""]*3)
    3.times{obj.next_frame}
    assert_equal(["", "", ""], obj.history)
  end
end
