# -*- coding: utf-8 -*-
require "spec_helper"

module Stylet
  describe Input::KeyOne do
    it "repeat" do
      obj = Input::KeyOne.new("?")
      cnt_ary, rep_ary = [], []
      6.times {
        obj.update(true)
        rep_ary << obj.repeat(3)
        cnt_ary << obj.count
      }
      rep_ary.should == [1, 0, 0, 0, 2, 3]
      cnt_ary.should == [1, 2, 3, 4, 5, 6]
    end

    it "EQ" do
      a = Input::KeyOne.new
      b = Input::KeyOne.new
      (a == b).should == true
      b.update(true)
      (a != b).should == true
    end

    it "EQ_for_sort" do
      a = Input::KeyOne.new
      b = Input::KeyOne.new
      (a <=> b).should == 0    # 0, 0
      b.update(true)
      (a <=> b).should == +1   # 0, 1
      a.update(true)
      b.update(true)
      (a <=> b).should == -1   # 1, 2
    end

    it "ARROR_LL" do
      a = Input::KeyOne.new
      a << (true | false)
      a.update
      a.count.should == 1
    end

    it "キーを離した瞬間がわかる" do
      a = Input::KeyOne.new
      a.update(true)
      a.free_trigger?.should be_false
      a.update(false)
      a.free_trigger?.should be_true
    end

    it "0.0 or 1.0 を返す(キーリピート対応)" do
      a = Input::KeyOne.new
      a.update(true)
      a.repeat_0or1.should == 1.0
      a.update(false)
      a.repeat_0or1.should == 0.0
    end
  end
end
