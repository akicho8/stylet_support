# -*- coding: utf-8 -*-
require_relative "../lib/stylet"
Stylet::Base.instance.title = "コードブロックを使ったストラテジー"
Stylet::Base.main_loop do |win|
  win.vputs "Hello, world."
end
