# -*- coding: utf-8 -*-
require "spec_helper"

module Stylet
  describe Vector do
    before do
      @p0 = Vector.new(10, 20)
      @p1 = Vector.new(100, 200)
      @obj = Vector.new(3, 4)
    end

    it "ランダム" do
      Vector.random
    end

    it "加減演算" do
      (@obj + @obj).should == Vector.new(6, 8)
      (@obj - @obj).should == Vector.new(0, 0)
    end

    it "スケーリング" do
      @obj.scale(2).should == Vector.new(6, 8)
      (@obj * 2).should == Vector.new(6, 8)
      (@obj * 0.5).should == Vector.new(1.5, 2.0)
    end

    it "正規化" do
      Vector.new(3, 4).normalize.should == Vector.new(0.6, 0.8)
    end

    describe "破壊的メソッド" do
      it {@p0.add!(@p1);  @p0.should == Vector.new(110, 220)}
      it {@p0.sub!(@p1);  @p0.should == Vector.new(-90, -180)}
      it {@p0.scale!(2);  @p0.should == Vector.new(20, 40)}
      it {@p0.normalize!; @p0}
    end

    it "長さ" do
      Vector.new(3, 4).length.should == 5
    end

    it "距離" do
      @p0.distance_to(@p1).to_i.should == 201
    end

    it "方向" do
      @p0.angle_to(@p1).should < 1.0
    end
  end
end
