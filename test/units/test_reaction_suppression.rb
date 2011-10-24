$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestReactionSuppression < Test::Unit::TestCase
  def test_reaction_suppression
    input  = ["r","r","r","","","l","l","","","r","r","r"]
    output = ["r","r","r","","", "","l","","", "","r","r"]
    obj = RSTextInputUnit.new(input)
    obj.rs.set_param(3,2,1)
    input.each{obj.next_frame}
    assert_equal(output, obj.history)
  end
end

