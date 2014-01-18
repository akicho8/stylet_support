# -*- coding: utf-8 -*-
require_relative "spec_helper"

module Stylet
  describe Etc do
    it do
      Etc.clamp(0.5).should == 0.5
      Etc.max_clamp(1.5).should == 1.0
      Etc.min_clamp(-0.5).should == 0.0
      Etc.abs_clamp(-1.5).should == -1.0

      Etc.shortest_angular_difference(0.2, 0.8).round(3).should == 0.4
      Etc.shortest_angular_difference(0.3, 0.8).round(3).should == -0.5
      Etc.shortest_angular_difference(0.4, 0.8).round(3).should == -0.4
    end
  end
end
