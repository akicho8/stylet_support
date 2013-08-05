# -*- coding: utf-8 -*-
#
# マウスで円をアイスホッケーの球のように動かすアルゴリズム
#
require_relative "helper"

#
# 円の中心
#    p0 (見えない)
#      \
#       \ radius
#        \
#         座標 pos (見える)
#          方向 dir
#
class IccHockeyBall
  def initialize(win, p0)
    @win = win
    @p0 = p0          # 物体の中心点
    @pos = @p0.clone  # 物体の位置
    @speed = 0        # 速度
    @radius = 0       # 中心からの移動量
    @dir = 0          # 中心からの移動角度
    @lock = false

    @body_radius = 64 # 物体の大きさ
    @speed_max = 16   # 速度最大
    @friction = 0.3   # 摩擦
  end

  def update
    # ボタンをクリックした瞬間に、
    if @win.button.btA.trigger?
      # 自分の円のなかにカーソルがあればロックする
      if @pos.distance_to(@win.mouse.point) < @body_radius
        @lock = true
      end
    end

    # ロックしているときに、ボタンが押されっぱなしなら
    if @lock && @win.button.btA.press?
      @p0 = @win.mouse.point.clone      # 円の座標をマウスと同じにする
      @power = @win.mouse.vector.length # マウスの直前からの移動距離を速度と考える
      @speed = 0                        # 速度を0とする
      @radius = 0                       # 半径を0とする
    end

    # ボタンが離された瞬間
    if @win.button.btA.free_trigger?
      # ロックを解除する
      @lock = false
      # 速度が設定されていれば
      if @power
        @speed = @power                  # 速度を円に反映し、
        @dir   = @win.mouse.vector.angle # 円の方向にマウスが移動した方向を合わせる
        @power = nil                     # 球が動いているときにボタンを連打すると @dir が再設定されてしまうので nil にしておく
      end
    end

    # 摩擦によって速度が落ちる
    @speed -= @friction

    # 速度調整
    @speed = Stylet::Etc.range_limited(@speed, (0..@speed_max))

    # 速度反映
    @radius += @speed

    # 進んだ位置を計算
    _p = Stylet::Vector.new
    _p.x = @p0.x + Stylet::Fee.cos(@dir) * @radius
    _p.y = @p0.y + Stylet::Fee.sin(@dir) * @radius

    # 画面内なら更新
    if Stylet::CollisionSupport.rect_in?(@win.rect, _p)
      @pos = _p
    end

    @win.draw_circle(@pos, :radius => @body_radius, :vertex => 32)
    @win.vputs @power
    @win.vputs @pos.distance_to(@win.mouse.point)
    @win.vputs @speed
    @win.vputs @radius
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::CursorWithObjectCollection

  def before_main_loop
    super if defined? super
    @objects << IccHockeyBall.new(self, rect.center.clone)
    @cursor.display = false
  end
end

App.main_loop
