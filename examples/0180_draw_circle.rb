# -*- coding: utf-8 -*-
#
# 円の描画
#
require "./setup"

Stylet.run(:title => "円の描画") do |win|
  win.draw_circle(win.rect.center, :vertex => 256)
end

