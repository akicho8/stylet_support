# -*- coding: utf-8 -*-
#
# 円上を動く三角
#
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

Stylet::Base.main_loop do |win|
  pos = Stylet::Vector.new(0, 0)
  pos.x = Stylet::Fee.cos(1.0 / 512 * (win.count * 3)) * win.rect.w * 0.3
  pos.y = Stylet::Fee.sin(1.0 / 512 * (win.count * 3)) * win.rect.h * 0.3
  win.draw_triangle(win.rect.center + pos, :radius => 64, :angle => pos.angle)
end
