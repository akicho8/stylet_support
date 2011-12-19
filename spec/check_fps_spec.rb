# -*- coding: utf-8 -*-
require "spec_helper"

describe Stylet::CheckFPS do
  it "0.5ずつフレームが切り替わっているということは2フレーム" do
    obj = Stylet::CheckFPS.new
    sleep(0.5)
    obj.update
    sleep(0.5)
    obj.update
    obj.fps.should == 2
  end
end
