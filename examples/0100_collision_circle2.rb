# -*- coding: utf-8 -*-
#
# 円同士の当り判定(ベクトルを使った方法)
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  def initialize(win, pos)
    @win = win
    @pos = pos
    @radius = 64
  end

  def update
    radius2 = @radius + @win.cursor_radius
    diff = @pos - @win.cursor
    if diff.length < radius2
      # @win.draw_line2(@pos, @win.cursor)
      @win.vputs "COLLISION"

      unless @win.button.btA.press?
        # カーソルの方向から円の位置の方向に一方的に移動させる
        @pos = @win.cursor + diff.normalize.scale(radius2)
        # @pos += diff.scale(diff.length)
      end
    end
    @win.draw_circle(@pos, :radius => @radius, :vertex => 32)
    # if @win.count.modulo(5) == 0
    #   @win.draw_line2(@pos, @win.cursor)
    # end
    # @win.vputs "radius2=#{radius2}"
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << Ball.new(self, srect.center.clone)
    @cursor_radius = 64
    @cursor_vertex = 32
  end
end

App.main_loop
