# -*- coding: utf-8 -*-
require "spec_helper"

describe Stylet::Vector do
  before do
    @p0 = Stylet::Vector.new(1, 2)
    @p1 = Stylet::Vector.new(10, 20)
  end

  it "加減演算" do
    (@p0 + @p1).should == Stylet::Vector.new(11, 22)
    (@p0 - @p1).should == Stylet::Vector.new(-9, -18)
  end

  it "距離" do
    @p0.distance(@p1).to_i.should == 20
  end

  it "方向" do
    @p0.angle(@p1).should < 1.0
  end
end
