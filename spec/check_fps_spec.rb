# -*- coding: utf-8 -*-
require "spec_helper"

module Stylet
  describe CheckFPS do
    it "0.5ずつフレームが切り替わっているということは2フレーム" do
      obj = CheckFPS.new
      sleep(0.5)
      obj.update
      sleep(0.5)
      obj.update
      obj.fps.should == 2
    end
  end
end
