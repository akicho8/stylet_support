# -*- coding: utf-8 -*-
#
# Vector#rotate の確認
#
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

pos = Stylet::Vector.new(100, 0)
Stylet::Base.main_loop do |win|
  pos = pos.rotate(1.0 / 256)
  win.draw_triangle(win.rect.center + pos, :radius => 64, :angle => pos.angle)
end
