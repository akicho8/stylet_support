# -*- coding: utf-8 -*-
require_relative "setup"
Stylet::Base.instance.title = "(title)"
Stylet::Base.main_loop do |win|
  win.vputs "Hello, world."
end
