# -*- coding: utf-8 -*-
require "spec_helper"

describe State do
  it "call" do
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
    trace_ary.should == [[:idol, 0], [:idol, 1], [:active, 0], [:active, 1]]
  end
end
