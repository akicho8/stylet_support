# -*- coding: utf-8 -*-
#
# ブランコのアルゴリズム
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

#
# ブランコのアルゴリズム
#
# 円の中心
#    p0 ----- pA (鉄球) ----> dir1 (pAの方向)
#       \     ↓
#        \    ↓
#         \   ↓gravity (重力)
#          \  ↓
#           \ ↓
#             pB (重力を反映した座標) ※仮想鉄球
#             \
#              dir2 (pBの方向)
#
class Swing
  def initialize(win, p0)
    @win = win
    @p0 = p0                     # 間接の座標
    @dir1 = Stylet::Fee.clock(1) # 角度
    @speed = 0                   # 角速度
    @friction = 0.0              # 摩擦(0.0:なし 1.0:最大)
    @radius = @win.rect.hy * 0.8 # 糸の長さ
    @ball_radius = 32            # 鉄球自体の半径
    @dir2 = nil                  # 振り子の中心(p0)からの重力反映座標(pB)の角度
  end

  def update
    # 鉄球の座標(pA)を求める
    @pA = @p0 + Stylet::Vector.sincos(@dir1).scale(@radius)

    # # 鉄球の座標から重力を反映した座標(pB)を求める
    # @pB = @pA + @win.gravity

    # 鉄球の座標から重力を反映した座標(pB)を求める(これはどういう数式？)
    v = @pA - @p0
    t = -(v.y * @win.gravity.y) / (v.x ** 2 + v.y ** 2)
    @pB = @pA + @win.gravity + v.scale(t)

    # 振り子の中心(p0)から重力反映座標(pB)の角度(@dir2)を求める
    @dir2 = @p0.angle_to(@pB)

    # 振り子の中心(p0)から重力反映座標(pB)への線を表示確認
    if @win.debug_mode
      @win.draw_line(@p0, @pB)
    end

    # 鉄球の角度が     dir1=0.9 (時計の14分の角度)
    # 仮想鉄球の角度が dir2=0.1 (時計の16分の角度)の場合、
    # 差分は正になるべきなのだけど
    # 差分を求めるために 0.1 - 0.9 をすると -0.8 になってしまい
    # 15分のあたりにいるのに逆向きに進もうとしてしまう。
    # これは15分の位置が一周の基点になっているためのおこる。
    # 対策として右半分にいるときかつ @dir2 の方が小さいとき @dir2 は一周したことにする
    # ただ 1.0 するのではなく @dir1 が進みすぎて一周したということにしたいので @dir1.round を加算してみたが、これはおかしくなる
    # 1.0 加算するのが正解っぽい
    if Stylet::Fee.cright?(@dir1)
      if @dir2 < @dir1
        @dir2 += 1.0
      end
    end

    # 仮想鉄球の角度と現在の角度の差を求める
    @sub = @dir2 - @dir1
    # @sub = (@pB - @pA).length
    # @win.vputs @sub

    # 加速
    @speed += @sub
    # 摩擦によって減速
    @speed *= (1.0 - @friction)
    # 進む
    @dir1 += @speed

    # Aボタンが押されているときだけ鉄球の位置をカーソルの方向に向ける
    if @win.button.btA.press?
      @dir1 = @p0.angle_to(@win.cursor)
      @speed = 0
    end

    # 中心と鉄球の線
    @win.draw_line(@p0, @pA)

    # 鉄球
    @win.draw_circle(@pA, :radius => @ball_radius, :vertex => 16)

    # デバッグモード
    if @win.debug_mode
      # 仮想鉄球への紐
      @win.draw_line(@p0, @pA)

      # 実鉄球から仮想鉄球への線
      @win.draw_line(@pA, @pB)
      @win.vputs "A", :vector => @pA
      @win.vputs "B", :vector => @pB

      # 90度ずらした線を引く
      rad90_line

      # 軌道の円周
      @win.draw_circle(@p0, :radius => @radius, :vertex => 32)

      # @win.vputs(@pA.to_a.inspect)
      # @win.vputs(@pB.to_a.inspect)
      # @win.vputs(@p0.to_a.inspect)

      @win.vputs "dir1=%+.8f" % @dir1
      @win.vputs "dir2=%+.8f" % @dir2
      @win.vputs "sub=%+.8f" % @sub
      @win.vputs "speed=%+.8f" % @speed
    end
  end

  def screen_out?
    false
  end

  # 90度ずらした線を引く
  def rad90_line
    _r = 128
    p2 = @pA + Stylet::Vector.sincos(@dir1 - Stylet::Fee.r90) * _r
    p3 = @pA + Stylet::Vector.sincos(@dir1 + Stylet::Fee.r90) * _r
    @win.draw_line(p2, p3)
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :debug_mode
  attr_reader :gravity

  def before_main_loop
    super if defined? super
    @objects << Swing.new(self, rect.center.clone)

    @debug_mode = true   # デバッグモード
    @gravity = Stylet::Vector.new(0, 100)   # 重力加速度(整数で指定すること)
  end

  def update
    super if defined? super

    # 操作
    begin
      # 重力調整
      @gravity.y += (@button.btC.repeat - @button.btD.repeat)
      @gravity.y = Stylet::Etc.range_limited(@gravity.y, (0..100))

      # 円の表示トグル
      if key_down?(SDL::Key::A)
        @debug_mode = !@debug_mode
      end
    end

    # 操作説明
    vputs "A:debug_mode"
    vputs "Z:drag C:g++ V:g--"
    vputs "gravity=#{@gravity.y}"
    # vputs "hard_level=#{@hard_level}"
  end
end

App.main_loop
