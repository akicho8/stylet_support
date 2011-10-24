$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestFrame < Test::Unit::TestCase
  def test_frame
    obj = Frame.new
  end
end
