# -*- coding: utf-8 -*-
#
# 円同士の当り判定(ベクトルを使った方法)
#
#   Aボタンを押していると引くモードになる
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  def initialize(win, pos)
    @win = win
    @pos = pos
    @radius = 100
  end

  def update
    radius2 = @radius + @win.cursor_radius
    if @pos != @win
      diff = @pos - @win.cursor
      if @win.button.btA.press?
        @win.vputs "PULL"
        if diff.length > radius2
          @pos = @win.cursor + diff.normalize.scale(radius2)
        end
      else
        @win.vputs "PUSH"
        if diff.length < radius2
          @pos = @win.cursor + diff.normalize.scale(radius2)
        end
      end
      @win.vputs "DIFF=#{diff.length}"
    end
    @win.draw_line(@pos, @win.cursor)
    @win.draw_circle(@pos, :radius => @radius, :vertex => 32)
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << Ball.new(self, rect.center.clone)
    @cursor_radius = 100
    @cursor_vertex = 32
  end
end

App.main_loop
