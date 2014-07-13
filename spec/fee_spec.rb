# -*- coding: utf-8 -*-
require "spec_helper"

module Stylet
  describe Fee do
    describe "整数系" do
      it "sin/cos" do
        Fee._rsin(0).should == 0
        Fee._rcos(0).should == Fee.one
      end

      it "sinとcosとatan2の整合性確認" do
        n = 64
        (0..n).collect{|i|
          r = (Fee.one_round * i / n) % Fee.one_round
          x = Fee._rcos(r)
          y = Fee._rsin(r)
          dir = Fee.iangle(0, 0, x, y)
          r == dir
        }.should be_all
      end

      it "二点間の角度を求める" do
        Fee.iangle(0, 0, 0, 1).should == Fee.one_round / 4
      end
    end

    describe "一周も角度も小数で表す系" do
      it "sin/cos" do
        Fee.rsin(0).should == 0.0
        Fee.rcos(0).should == 1.0
      end

      it "sinとcosとatan2の整合性確認" do
        n = 32
        (0..n).collect{|i|
          r = 1.0 * i / n % 1.0
          x = Fee.rcos(r)
          y = Fee.rsin(r)
          dir = Fee.angle(0, 0, x, y)
          r == dir
        }.should be_all
      end
    end

    it "時計の時で方向指定" do
      Fee.clock(0).should  == 0.75
      Fee.clock(3).should  == 0.0
      Fee.clock(6).should  == 0.25
      Fee.clock(9).should  == 0.5
      Fee.clock(12).should == 0.75
    end

    it "方向を抽象化" do
      Fee.r0.should == Fee.clock(3)
      (Fee.r45 * 10000).round.should == (Fee.clock(4, 30) * 10000).round
      Fee.r90.should == Fee.clock(6)
      Fee.r180.should == Fee.clock(9)
    end

    it "左右どちらにいるか？" do
      Fee.cright?(Fee.clock(3)).should == true
      Fee.cleft?(Fee.clock(9)).should == true
    end
  end
end
