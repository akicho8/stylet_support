# -*- coding: utf-8 -*-
#
# 回転する三角形
#
require "./setup"
Stylet.run(:title => "回転する三角形の描画") do |win|
  win.draw_triangle(win.rect.center, :radius => 128, :angle => 1.0 / 256 * win.count)
end
