# -*- coding: utf-8 -*-
require "spec_helper"

describe Stylet::Fee do
  it "角度を整数で渡す系" do
    Stylet::Fee.isin(0).should == 0.0
    Stylet::Fee.icos(0).should == 1.0
  end

  it "一周を1.0として渡せる系" do
    Stylet::Fee.sin(0).should == 0.0
    Stylet::Fee.cos(0).should == 1.0
  end

  it "二点間の角度を求める" do
    Stylet::Fee.iangle(0, 0, 0, 1).should == Stylet::Fee.one / 4
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
    Stylet::Fee.r45.to_s.should == Stylet::Fee.clock(4, 30).to_s
    Stylet::Fee.r90.should == Stylet::Fee.clock(6)
    Stylet::Fee.r180.should == Stylet::Fee.clock(9)
  end

  it "左右どちらにいるか？" do
    Stylet::Fee.cright?(Stylet::Fee.clock(3)).should be_true
    Stylet::Fee.cleft?(Stylet::Fee.clock(9)).should be_true
  end
end
