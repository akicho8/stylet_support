$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestState < Test::Unit::TestCase
  def test_call
    trace_ary = []
    object = State.new(:idol)
    loop_flag = true
    while loop_flag
      object.transition_safe do
        trace_ary << [object.state, object.count]
        case object.state
        when :active
          if object.count_at?(1)
            loop_flag = false
          end
        when :idol
          if object.count_at?(1)
            object.transition!(:active)
          end
        end
      end
    end
    assert_equal [[:idol, 0], [:idol, 1], [:active, 0], [:active, 1]], trace_ary
  end
end
