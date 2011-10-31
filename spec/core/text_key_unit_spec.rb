# -*- coding: utf-8 -*-
require "spec_helper"

describe TextInputUnit do
  it "new" do
    obj = TextInputUnit.new(["udlrABCD", "", "ud"])

    obj.next_frame
    # UDがあるとLRが無効になる
    obj.to_s.should == "udABCD"

    obj.next_frame
    obj.to_s.should == ""

    obj.next_frame
    obj.to_s.should == "ud"

    obj.history.should == ["udABCD", "", "ud"]
  end

  it "new2" do
    obj = TextInputUnit.new("A B C")
    3.times{obj.next_frame}
    obj.history.should == ["A", "B", "C"]
  end

  it "new3" do
    obj = TextInputUnit.new([""] * 3)
    3.times{obj.next_frame}
    obj.history.should == ["", "", ""]
  end
end
