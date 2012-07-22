# -*- coding: utf-8 -*-
#
# 円の描画
#
require_relative "../lib/stylet"

Stylet::Base.instance.title = "円の描画"
Stylet::Base.main_loop do |win|
  win.draw_polygon(win.rect.center, :vertex => 256)
end
