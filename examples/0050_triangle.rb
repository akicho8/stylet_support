# -*- coding: utf-8 -*-
#
# 回転する三角形の描画
#
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

Stylet::Base.main_loop do |base|
  base.draw_circle(base.half_pos, :radius => 128, :vertex => 3, :angle => 1.0 / 256 * base.count)
end
