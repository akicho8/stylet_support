# -*- coding: utf-8 -*-
#
# 円の描画
#
require_relative "../lib/stylet"

Stylet::Base.instance.title = "円の描画"
Stylet.run do |win|
  win.draw_circle(win.rect.center, :vertex => 256)
end

