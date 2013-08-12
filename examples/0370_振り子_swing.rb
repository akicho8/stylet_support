# -*- coding: utf-8 -*-
#
# 振り子のアルゴリズム
#
require_relative "helper"

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
  def initialize(win)
    @win = win
    @p0 = @win.rect.center + Stylet::Vector.new(0, -@win.rect.h * 0)   # 円の中心
    @dir1 = Stylet::Fee.clock(1) # 角度
    @speed = 0                   # 角速度
    @friction = 0.0              # 摩擦(0.0:なし 1.0:最大)
    @radius = @win.rect.hy * 0.5 # 糸の長さ
    @ball_radius = 32            # 鉄球自体の半径
    @dir2 = nil                  # 振り子の中心(p0)からの重力反映座標(pB)の角度
    @gravity = Stylet::Vector.new(0, 1)   # 重力加速度(整数で指定すること)
    @debug_mode = false
  end

  def update
    begin
      if @win.button.btA.press? || @win.button.btB.press?
        # 重力調整
        @gravity += @gravity.normalize.scale(@win.button.btA.repeat) + @gravity.normalize.scale(-@win.button.btB.repeat)
        @gravity.y = Stylet::Etc.range_limited(@gravity.y, (1..@radius))
        @speed = 0
      end

      # Aボタンが押されているときだけ鉄球の位置をカーソルの方向に向ける
      if @win.button.btD.press?
        @dir1 = @p0.angle_to(@win.cursor.point)
        @speed = 0
      end

      if @win.button.btC.trigger?
        @debug_mode = !@debug_mode
      end
    end

    # 鉄球の座標(pA)を求める
    @pA = @p0 + Stylet::Vector.angle_at(@dir1).scale(@radius)

    # 鉄球の座標から重力を反映した座標(pB)を求める(pBを経由しなくてもpCは求まる)
    @pB = @pA + @gravity

    # 鉄球の座標から重力を反映した座標(pC)を求める(これはどういう数式？)
    v = @pA - @p0
    t = -(v.y * @gravity.y) / (v.x ** 2 + v.y ** 2)
    @pC = @pA + @gravity + v.scale(t)

    # 振り子の中心(p0)から重力反映座標(pC)の角度(@dir2)を求める
    @dir2 = @p0.angle_to(@pC)

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
    @diff = @dir2 - @dir1
    # @diff = (@pC - @pA).length
    # @win.vputs @diff

    # 加速
    @speed += @diff
    # 摩擦によって減速
    @speed *= (1.0 - @friction)
    # 進む
    @dir1 += @speed

    # 中心と鉄球の線
    @win.draw_line(@p0, @pA)

    # 鉄球
    @win.draw_circle(@pA, :radius => @ball_radius, :vertex => 16)

    # デバッグモード
    if @debug_mode || @win.button.btD.press?
      # 仮想鉄球への紐
      @win.draw_line(@p0, @pA)

      # 実鉄球から仮想鉄球への線
      # @win.draw_line(@p0, @pB)
      @win.draw_line(@p0, @pC) # 振り子の中心(p0)から重力反映座標(pC)への線を表示確認
      @win.draw_line(@pA, @pB)
      @win.draw_line(@pB, @pC)
      @win.draw_line(@pA, @pC)
      @win.vputs "P", :vector => @p0
      @win.vputs "A", :vector => @pA
      @win.vputs "B", :vector => @pB
      @win.vputs "C", :vector => @pC

      # 90度ずらした線を引く
      rad90_line

      # 軌道の円周
      @win.draw_circle(@p0, :radius => @radius, :vertex => 32)

      # @win.draw_line(@pB, @pB + (@pA - @pB).scale(2))
    end

    @win.vputs "dir1: #{@dir1}"
    @win.vputs "dir2: #{@dir2}"
    @win.vputs "diff: #{@diff}"
    @win.vputs "speed: #{@speed}"
    @win.vputs "gravity: #{@gravity.length}"

    @win.vputs "Z:g++ X:g-- C:debug V:drag"
  end

  # 90度ずらした線を引く
  def rad90_line
    # @win.draw_line(@pB, @pC)
    # _r = 256
    # p2 = @pA + Stylet::Vector.angle_at(@dir1 - Stylet::Fee.r90) * _r
    # p3 = @pA + Stylet::Vector.angle_at(@dir1 + Stylet::Fee.r90) * _r
    # @win.draw_line(p2, p3)
  end
end

class App < Stylet::Base
  include Helper::CursorWithObjectCollection

  def before_run
    super if defined? super
    @objects << Swing.new(self)
    self.title = "振り子"
  end
end

App.run
