# -*- coding: utf-8 -*-
#
# 回転する三角形
#
require_relative "../lib/stylet"
Stylet::Base.instance.title = "回転する三角形の描画"
Stylet.run do |win|
  win.draw_triangle(win.rect.center, :radius => 128, :angle => 1.0 / 256 * win.count)
end
