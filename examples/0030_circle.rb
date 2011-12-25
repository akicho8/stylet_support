# -*- coding: utf-8 -*-
# 円の書き方
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

Stylet::Base.main_loop do |base|
  base.draw_circle(base.half_pos)
end
