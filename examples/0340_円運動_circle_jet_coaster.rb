# -*- coding: utf-8 -*-
#
# ギャラガの敵の動き
#
require_relative "helper"

class Ball
  def initialize(win, index)
    @win = win
    @index = index
  end

  def update
    p0 = pos_new(@win.count)      # 現在の位置を取得
    p1 = pos_new(@win.count.next) # 次のフレームの位置を取得
    dir = p0.angle_to(p1)          # 現在の位置から見て未来の角度を取得
    @win.draw_circle(p0, :radius => 20, :vertex => 3, :angle => dir) # 次に進む方向に向けて三角を表示
  end

  #
  # countフレーム地点の位置を取得
  #
  def pos_new(count)
    pos = Stylet::Vector.new
    pos.x = Stylet::Fee.cos(1.0 / 512 * (count * @win.xc + @index * 24)) * @win.rect.w * 0.4
    pos.y = Stylet::Fee.sin(1.0 / 512 * (count * @win.yc + @index * 24)) * @win.rect.h * 0.4
    @win.rect.center + pos
  end
end

class App < Stylet::Base
  include Helper::CursorWithObjectCollection

  attr_reader :xc, :yc

  def before_run
    super if defined? super
    @cursor.display = false
    @objects += Array.new(16){|i|Ball.new(self, i)}
    @xc = 3.0
    @yc = 3.0
  end

  def update
    super if defined? super
    @xc += 0.5 * (@button.btA.repeat + -@button.btB.repeat)
    @yc += 0.5 * (@button.btC.repeat + -@button.btD.repeat)
    vputs [@xc, @yc].inspect
  end
end

App.run
