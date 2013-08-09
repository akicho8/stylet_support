# -*- coding: utf-8 -*-
require_relative "setup"
Stylet::Base.instance.title = "(title)"
Stylet.run do |win|
  win.vputs "Hello, world."
end
