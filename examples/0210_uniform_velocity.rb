# -*- coding: utf-8 -*-
#
# 等速移動
#
#   いろんな多角形が落ちてくるだけ
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  def initialize(win)
    @win = win
    @gravity = Stylet::Vector.new(0, 0.05)

    @vertex = 3 + rand(3)
    @radius = 2 + rand(24)
    @arrow = rand(2).zero? ? 1 : -1

    @pos = Stylet::Vector.new(rand(@win.srect.w), @win.srect.min_y - @radius * 2)
    @speed = Stylet::Vector.sincos(Stylet::Fee.clock(6)).scale(1 + rand * 2)
  end

  def reset
  end

  def update
    # 操作
    begin
      # # AとBで速度ベクトルの反映
      # # @pos += @speed.scale(@win.button.btA.repeat_0or1) + @speed.scale(-@win.button.btB.repeat_0or1)
      # if @win.button.btA.press?
      #   @speed += @gravity
      # end
      # 
      # # Cボタンおしっぱなし + マウスで自機位置移動
      # if @win.button.btC.press?
      #   @pos = @win.cursor.clone
      # end
      # 
      # # Dボタンおしっぱなし + マウスで自機角度変更
      # if @win.button.btD.press?
      #   if @win.cursor != @pos
      #     @speed = (@win.cursor - @pos).normalize * @speed.length
      #   end
      # end
    end

    @pos += @speed

    # 落ちたら死ぬ
    max = @win.srect.max_y + @radius * 2
    if @pos.y > max
      @win.objects.delete(self)
    end

    @win.draw_circle(@pos, :radius => @radius, :vertex => @vertex, :angle => 1.0 / 256 * (@speed.length + @win.count) * @arrow)

    # @win.draw_rect2(@win.srect)
    # @win.draw_rect2(@rect.add_vector(@pos))
    # @win.draw_vector(@speed.scale(@radius / 2), :origin => @pos)
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :mode

  def before_main_loop
    super if defined? super
    @cursor_display = false
  end

  def update
    super if defined? super
    if @count.modulo(4).zero?
      @objects << Ball.new(self)
    end
  end
end

App.main_loop
