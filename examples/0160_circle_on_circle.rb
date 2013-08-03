# -*- coding: utf-8 -*-
#
# 円上を動く円
#
require_relative "../lib/stylet"

Stylet::Base.instance.title = "円上を動く円"
Stylet::Base.main_loop do |win|
  pos = Stylet::Vector.angle_at(1.0 / 256 * win.count) * win.rect.h * 0.3
  win.draw_circle(win.rect.center + pos, :vertex => 128, :radius => 64, :angle => pos.angle)
end
