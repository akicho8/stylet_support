# -*- coding: utf-8 -*-
#
# マウスで円をアイスホッケーの球のように動かすアルゴリズム
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class IccHockeyBall
  def initialize(base, cpos)
    @base = base
    @cpos = cpos
    @pos = @cpos.clone
    @radius = 64       # 物体の大きさ
    @vr_max = 12       # 速度最大
    @friction = 0.15 # 摩擦
    @vr = 0
    @r = 0
    @dir = 0
    @lock = false
  end

  def update
    # ボタンをクリックした瞬間に、
    if @base.button.btA.trigger?
      # 自分の円のなかにカーソルがあればロックする
      if @pos.distance(@base.mpos) < @radius
        @lock = true
      end
    end

    # ロックしているときに、ボタンが押されっぱなしなら
    if @lock && @base.button.btA.press?
      @cpos = @base.mpos.clone # 円の座標をマウスと同じにする
      @vr = 0                  # 速度を0とする
      @r = 0                   # 半径を0とする
      # マウスの移動距離と、速度と考えて @power に設定する
      @power = @base.__mouse_vector
    end

    # ボタンが離された瞬間
    if @base.button.btA.free_trigger?
      # ロックを解除する
      @lock = false
      # 速度が設定されていれば
      if @power
        # 速度を円に反映し、
        @vr = @power
        # 円の方向のにマウスが移動した方向を合わせる
        @dir = @base.mouse_dir
        # 球が動いているときにボタンを連打すると @dir が再設定されてしまうので nil にしておく
        @power = nil
      end
    end

    # 摩擦によって速度が減っていく
    @vr -= @friction

    # 速度調整
    @vr = Stylet::Etc.range_limited(@vr, (0..@vr_max))

    # 速度反映
    @r += @vr

    # 進んだ位置を計算
    _p = Stylet::Point.new
    _p.x = @cpos.x + Stylet::Fee.rcosf(@dir) * @r
    _p.y = @cpos.y + Stylet::Fee.rsinf(@dir) * @r

    # 画面内なら更新
    if Stylet::CollisionSupport.rect_collision?(@base.screen_rect, _p)
      @pos = _p
    end

    @base.draw_circle(@pos, :radius => @radius, :vertex => 32)
    @base.vputs @power
    @base.vputs @pos.distance(@base.mpos)
    @base.vputs @vr
    @base.vputs @r
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << IccHockeyBall.new(self, half_pos.clone)
    @cursor_display = false
  end
end

App.main_loop
