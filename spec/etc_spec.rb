# -*- coding: utf-8 -*-
require "spec_helper"

describe Stylet::Etc do
  it do
    Stylet::Etc.range_limited(0.5).should == 0.5
    Stylet::Etc.upper_limited(1.5).should == 1.0
    Stylet::Etc.lower_limited(-0.5).should == 0.0
  end
end
