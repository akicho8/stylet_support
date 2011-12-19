# -*- coding: utf-8 -*-
require "spec_helper"

describe Stylet::Fee do
  it "角度を整数で渡す系" do
    Stylet::Fee.rsin(0).should == 0.0
    Stylet::Fee.rcos(0).should == 1.0
  end

  it "一周を1.0として渡せる系" do
    Stylet::Fee.rsinf(0).should == 0.0
    Stylet::Fee.rcosf(0).should == 1.0
  end

  it "二点間の角度を求める" do
    Stylet::Fee.rdir(0, 0, 0, 1).should == 1024.0
  end
end
