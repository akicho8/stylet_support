# -*- coding: utf-8 -*-
#
# 円同士の当り判定(ベクトルを使った方法)
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  def initialize(base, pos)
    @base = base
    @pos = pos
    @radius = 64
  end

  def update
    radius2 = @radius + @base.cursor_radius
    diff = @pos - @base.cursor
    if diff.length < radius2
      # @base.draw_line2(@pos, @base.cursor)
      @base.vputs "COLLISION"

      if @base.button.btA.press?
        # カーソルの方向から円の位置の方向に一方的に移動させる
        @pos = @base.cursor + diff.normalize.scale(radius2)
        # @pos += diff.scale(diff.length)
      end
    end
    @base.draw_circle(@pos, :radius => @radius, :vertex => 32)
    # if @base.count.modulo(5) == 0
    #   @base.draw_line2(@pos, @base.cursor)
    # end
    # @base.vputs "radius2=#{radius2}"
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << Ball.new(self, half_pos.clone)
    @cursor_radius = 64
    @cursor_vertex = 32
  end
end

App.main_loop
