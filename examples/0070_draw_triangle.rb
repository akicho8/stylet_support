# -*- coding: utf-8 -*-
#
# 回転する三角形
#
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))
Stylet::Base.instance.title = "回転する三角形の描画"
Stylet::Base.main_loop do |win|
  win.draw_triangle(win.rect.center, :radius => 128, :angle => 1.0 / 256 * win.count)
end
