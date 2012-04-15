# -*- coding: utf-8 -*-
require "spec_helper"

describe Stylet::Fee do
  describe "整数系" do
    it "sin/cos" do
      Stylet::Fee.isin(0).should == 0
      Stylet::Fee.icos(0).should == Stylet::Fee.one
    end

    it "sinとcosとatan2の整合性確認" do
      n = 64
      (0..n).collect{|i|
        r = (Stylet::Fee.one_round * i / n) % Stylet::Fee.one_round
        x = Stylet::Fee.icos(r)
        y = Stylet::Fee.isin(r)
        dir = Stylet::Fee.iangle(0, 0, x, y)
        # p [x, y, r, dir, (r == dir)]
        r == dir
      }.should be_all
    end

    it "二点間の角度を求める" do
      Stylet::Fee.iangle(0, 0, 0, 1).should == Stylet::Fee.one_round / 4
    end
  end

  describe "一周も角度も小数で表す系" do
    it "sin/cos" do
      Stylet::Fee.sin(0).should == 0.0
      Stylet::Fee.cos(0).should == 1.0
    end

    it "sinとcosとatan2の整合性確認" do
      n = 32
      (0..n).collect{|i|
        r = 1.0 * i / n % 1.0
        x = Stylet::Fee.cos(r)
        y = Stylet::Fee.sin(r)
        dir = Stylet::Fee.angle(0, 0, x, y)
        # p [i, r, dir]
        r == dir
      }.should be_all
    end
  end

  it "時計の時で方向指定" do
    Stylet::Fee.clock(0).should == 0.75
    Stylet::Fee.clock(3).should == 0.0
    Stylet::Fee.clock(6).should == 0.25
    Stylet::Fee.clock(9).should == 0.5
    Stylet::Fee.clock(12).should == 0.75
  end

  it "方向を抽象化" do
    Stylet::Fee.r0.should == Stylet::Fee.clock(3)
    (Stylet::Fee.r45 * 10000).round.should == (Stylet::Fee.clock(4, 30) * 10000).round
    Stylet::Fee.r90.should == Stylet::Fee.clock(6)
    Stylet::Fee.r180.should == Stylet::Fee.clock(9)
  end

  it "左右どちらにいるか？" do
    Stylet::Fee.cright?(Stylet::Fee.clock(3)).should be_true
    Stylet::Fee.cleft?(Stylet::Fee.clock(9)).should be_true
  end
end
