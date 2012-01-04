# -*- coding: utf-8 -*-
#
# 円の描画
#
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

Stylet::Base.main_loop do |win|
  win.draw_circle(win.srect.half_pos, :vertex => 256)
end
