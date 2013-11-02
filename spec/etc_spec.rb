# -*- coding: utf-8 -*-
require "spec_helper"

module Stylet
  describe Etc do
    it do
      Etc.range_limited(0.5).should == 0.5
      Etc.upper_limited(1.5).should == 1.0
      Etc.lower_limited(-0.5).should == 0.0
      Etc.abs_limited(-1.5).should == -1.0
    end
  end
end
