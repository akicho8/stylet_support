require "spec_helper"

describe Stylet::Input::Base do
  class Stylet::Input::BaseClass
    include Stylet::Input::Base
  end

  it "new" do
    obj = Stylet::Input::BaseClass.new
    obj.button.to_a.first.should be_an_instance_of(Stylet::Input::KeyOne)
    obj.button.to_a.first.should be_a_kind_of(Stylet::Input::KeyOne)
  end
end
