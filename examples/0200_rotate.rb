# -*- coding: utf-8 -*-
#
# Vector#rotate の確認
#
require "./setup"

pos1 = Stylet::Vector.new(100, 0)
pos2 = Stylet::Vector.new(100, 0)
Stylet.run(:title => "Vector#rotate系の二つのメソッドの確認") do |win|
  pos1 = pos1.rotate(1.0 / 256)
  pos2 = pos2.rotate2(1.0 / 256)
  win.vputs(pos1 == pos2)
  win.vputs "1: #{pos1.to_a.inspect}"
  win.vputs "2: #{pos2.to_a.inspect}"
  win.draw_triangle(win.rect.center + pos1, :radius => 64, :angle => pos1.angle)
  win.draw_triangle(win.rect.center + pos2, :radius => 64, :angle => pos2.angle)
end
