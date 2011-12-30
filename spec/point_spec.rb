# -*- coding: utf-8 -*-
require "spec_helper"

describe Stylet::Point do
  before do
    @p0 = Stylet::Point.new(1, 2)
    @p1 = Stylet::Point.new(10, 20)
  end

  it "加減演算" do
    (@p0 + @p1).should == Stylet::Point.new(11, 22)
    (@p0 - @p1).should == Stylet::Point.new(-9, -18)
  end

  it "距離" do
    @p0.distance(@p1).to_i.should == 20
  end

  it "方向" do
    @p0.rdirf(@p1).should < 1.0
  end
end
