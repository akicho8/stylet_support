$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestInputUnit < Test::Unit::TestCase
  def test_new
    obj = InputUnit.new
    assert_instance_of(KeyOne, obj.button.to_a.first)
    assert_kind_of(KeyOne, obj.button.to_a.first)
  end
end
