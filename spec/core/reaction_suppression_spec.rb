# -*- coding: utf-8 -*-
require "spec_helper"

describe ReactionSuppression do
  it "反動抑制が効いている" do
    input  = ["r", "r", "r", "", "", "l", "l", "", "", "r", "r", "r"]
    output = ["r", "r", "r", "", "",  "", "l", "", "",  "", "r", "r"]
    obj = RSTextInputUnit.new(input)
    obj.rs.set_param(3, 2, 1)
    input.each{obj.next_frame}
    obj.history.should == output
  end
end

