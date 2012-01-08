# -*- coding: utf-8 -*-
#
# 回転する三角形の描画
#
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

Stylet::Base.main_loop do |win|
  win.draw_circle(win.srect.center, :radius => 128, :vertex => 3, :angle => 1.0 / 256 * win.count)
end
