# -*- coding: utf-8 -*-
# 円の書き方
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

class App < Stylet::Base
  def update
    super
    draw_circle(half_pos)
  end
end

App.main_loop
