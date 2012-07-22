# -*- coding: utf-8 -*-
#
# 等速移動
#
#   いろんな多角形が落ちてくるだけ
#
require_relative "helper"

class Ball
  def initialize(win)
    @win = win
    @gravity = Stylet::Vector.new(0, 0.05)

    @vertex = 3 + rand(3)
    @radius = 2 + rand(24)
    @arrow = rand(2).zero? ? 1 : -1

    @pos = Stylet::Vector.new(rand(@win.rect.w), @win.rect.min_y - @radius * 2)
    @speed = Stylet::Vector.angle_at(Stylet::Fee.clock(6)).scale(1 + rand * 2)
  end

  def reset
  end

  def update
    @pos += @speed

    # 落ちたら死ぬ
    max = @win.rect.max_y + @radius * 2
    if @pos.y > max
      @win.objects.delete(self)
    end

    @win.draw_polygon(@pos, :radius => @radius, :vertex => @vertex, :angle => 1.0 / 256 * (@speed.length + @win.count) * @arrow)
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @cursor_display = false
    self.title = "等速落下"
  end

  def update
    super if defined? super
    if @count.modulo(4).zero?
      @objects << Ball.new(self)
    end
  end
end

App.main_loop
