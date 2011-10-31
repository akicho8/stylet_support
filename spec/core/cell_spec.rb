# -*- coding: utf-8 -*-
require "spec_helper"

describe Cell do
  it "exist?" do
    obj = Cell.new("b")
    obj.exist?.should == true
    obj.clear!
    obj.exist?.should == false
  end

  it "getid" do
    Cell.new("b").color.should == "b"
  end

  it "color" do
    Cell.new("b").color.should == "b"
  end

  it "EQ" do
    (Cell.new("c") == Cell.new("b")).should == false
    (Cell.new("c") == Cell.new("c")).should == true
    a = Cell.new("c")
    b = Cell.new("b")
    b.clear!
    (a == b).should == false
    (a == nil).should == false
  end

  it "to_s" do
    obj = Cell.new("b")
    obj.to_s.should == "b"
    obj.clear!
    obj.to_s.should == "."
  end
end
