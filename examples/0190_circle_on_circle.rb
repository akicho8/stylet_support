# -*- coding: utf-8 -*-
#
# 円上を動く円
#
require_relative "setup"
include Stylet

run(:title => "円上を動く円") do
  pos = Vector.angle_at(1.0 / 256 * count * 2) * rect.h * 0.3
  draw_circle(rect.center + pos, :vertex => 8, :radius => 64, :angle => pos.angle * 3)
end
