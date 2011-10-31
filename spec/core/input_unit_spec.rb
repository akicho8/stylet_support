# -*- coding: utf-8 -*-
require "spec_helper"

describe InputUnit do
  it "new" do
    obj = InputUnit.new
    obj.button.to_a.first.should be_an_instance_of(KeyOne)
    obj.button.to_a.first.should be_a_kind_of(KeyOne)
  end
end
