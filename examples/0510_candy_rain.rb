# -*- coding: utf-8 -*-
#
# 雨
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Scene
  def initialize(win, index)
    @win = win
    @index = index

    @gravity = Stylet::Vector.new(0, 0.05)

    @vertex = 3 + rand(3)
    @radius = 2 + rand(24)
    @arrow = rand(2).zero? ? 1 : -1

    reset

    @pA = Stylet::Vector.new(rand(@win.srect.w), rand(@win.srect.h))
  end

  def reset
    @pA = Stylet::Vector.new(rand(@win.srect.w), @win.srect.min_y - @radius * 2)
    @speed = Stylet::Vector.sincos(Stylet::Fee.clock(6)).scale(1 + rand * 2)
  end

  def update
    # 操作
    begin
      # AとBで速度ベクトルの反映
      # @pA += @speed.scale(@win.button.btA.repeat_0or1) + @speed.scale(-@win.button.btB.repeat_0or1)
      if @win.button.btA.press?
        @speed += @gravity
      end
      @pA += @speed

      # 外に出てしまったらスピード反転

      # @win.vputs Stylet::CollisionSupport.rect_include?(@win.srect, @rect.add_vector(@pA)).inspect
      # unless Stylet::CollisionSupport.rect_include?(@win.srect, @rect.add_vector(@pA))
      max = @win.srect.max_y + @radius * 2
      if @pA.y > max
        reset
      end

      # Cボタンおしっぱなし + マウスで自機位置移動
      if @win.button.btC.press?
        @pA = @win.cursor.clone
      end
      # Dボタンおしっぱなし + マウスで自機角度変更
      if @win.button.btD.press?
        if @win.cursor != @pA
          @speed = (@win.cursor - @pA).normalize * @speed.radius
        end
      end
    end

    @win.draw_circle(@pA, :radius => @radius, :vertex => @vertex, :angle => 1.0 / 256 * (@speed.length + @win.count) * @arrow)

    # @win.draw_rect2(@win.srect)
    # @win.draw_rect2(@rect.add_vector(@pA))
    # @win.draw_vector(@speed.scale(@radius / 2), :origin => @pA)
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :mode

  def before_main_loop
    super if defined? super
    @objects = Array.new(32){|i|Scene.new(self, i)}
    @cursor_display = false
  end
end

App.main_loop
