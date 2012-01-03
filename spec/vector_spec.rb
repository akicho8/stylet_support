# -*- coding: utf-8 -*-
require "spec_helper"

describe Stylet::Vector do
  before do
    @p0 = Stylet::Vector.new(10, 20)
    @p1 = Stylet::Vector.new(100, 200)
  end

  it "ランダム" do
    Stylet::Vector.random
  end

  it "加減演算" do
    (@p0 + @p1).should == Stylet::Vector.new(110, 220)
    (@p0 - @p1).should == Stylet::Vector.new(-90, -180)
  end

  it "スケーリング" do
    @p0.scale(2.0).should == Stylet::Vector.new(20, 40)
  end

  it "正規化" do
    Stylet::Vector.new(10, 20).normalize
    Stylet::Vector.new(10, -20).normalize

    # Stylet::Vector.new(10, 20).normalize.should == Stylet::Vector.new(0.5, 1.0)
    # Stylet::Vector.new(10, -20).normalize.should == Stylet::Vector.new(0.5, -1.0)
    # Stylet::Vector.new(0, 0).normalize.should == Stylet::Vector.new(NaN, NaN)
  end

  describe "破壊的メソッド" do
    it {@p0.add!(@p1);  @p0.should == Stylet::Vector.new(110, 220)}
    it {@p0.sub!(@p1);  @p0.should == Stylet::Vector.new(-90, -180)}
    it {@p0.scale!(2);  @p0.should == Stylet::Vector.new(20, 40)}
    it {@p0.normalize!; @p0}
  end

  it "長さ" do
    @p0.length.to_s.should == "22.3606797749979"
  end

  it "距離" do
    @p0.distance_to(@p1).to_i.should == 201
  end

  it "方向" do
    @p0.angle_to(@p1).should < 1.0
  end
end
