# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))
Stylet::Base.instance.title = "コードブロックを使ったストラテジー"
Stylet::Base.main_loop do |win|
  win.vputs "Hello, world."
end
