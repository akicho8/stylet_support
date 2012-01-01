# -*- coding: utf-8 -*-
#
# レイの当り判定
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ray
  def initialize(base, p0)
    @base = base

    @p0 = p0                               # 自機の位置ベクトル
    @radius = 16                           # 自機の大きさ
    @speed = Stylet::Vector.new(0.5, 0.05).normalize # 自機の速度ベクトル

    # 線分AB
    @pA = @base.half_pos + Stylet::Vector.new(@base.half_x * 0.4, -@base.half_y * 0.5)
    @pB = @base.half_pos + Stylet::Vector.new(@base.half_x * 0.1, +@base.half_y * 0.5)
  end

  def update
    # 操作
    begin
      # Aボタンおしっぱなし + マウスで自機位置移動
      if @base.button.btA.press?
        @p0 = @base.cursor.clone
      end
      # Bボタンおしっぱなし + マウスで自機角度変更
      if @base.button.btB.press?
        @speed = Stylet::Vector.sincos(@p0.angle_to(@base.cursor)) * @speed.radius
      end
      # # CとDで速度ベクトルの反映
      @p0 += @speed.scale(@base.button.btC.repeat_0or1) + @speed.scale(-@base.button.btD.repeat_0or1)
    end

    # 線の表裏どちらにいるか。また衝突しているか？ (この時点では無限線)
    begin
      # 法線取得
      @normal = @pA.normal(@pB)
      @base.vputs "Normal: #{@normal.to_a.inspect}"

      # スピードベクトルをt倍したら線に衝突するかを求める
      # 自機の原点・速度ベクトル・法線の原点(pAでもpBでもよい)・法線ベクトルを渡すと求まる
      @t = Stylet::Vector.collision_scale(@p0, @speed, @pA, @normal)

      # 裏面(通りすぎている) <= 0.0 < 衝突 <= 1.0 < 表面(まだあたっていない)
      if @t > 1.0
        state = "FACE"
      elsif 0.0 < @t && @t <= 1.0
        state = "COLLISION"
      else # @t <= 0.0
        state = "REVERSE"
      end
      @base.vputs "t: #{@t} (#{state})"

      # スピードを t 倍したとき本当にラインに接触するのかを見える化
      @base.draw_vector(@speed.scale(@t), :origin => @p0)
    end

    # 線分ABの中に衝突しているか調べる方法
    begin
      # 交差点の取得
      @pC = @p0 + @speed.scale(@t)

      # 交差点の視覚化
      @base.vputs "C", :vector => @pC

      # 内積の取得
      @ac = @pC - @pA
      @bc = @pC - @pB
      @doc = Stylet::Vector.inner_product(@ac, @bc)
      #   1. ←← or →→ 正 (0.0 < v)   お互いだいたい同じ方向を向いている
      #   2. →←         負 (v   < 0.0) お互いだいたい逆の方向を向いている
      #   3. →↓ →↑    零 (0.0)       お互いが直角の関係
      if @doc < 0
        inner_product_state = "COLLISION"
      else
        inner_product_state = "OUT"
      end
      @base.vputs "inner_product: #{@doc} (#{inner_product_state})"

      # 二つのベクトルがどちらを向いているか視覚化(お互いが衝突していたら線の中にいることがわかる)
      @base.draw_vector(@ac.normalize.scale(20), :origin => @pA, :arrow_size => 16)
      @base.draw_vector(@bc.normalize.scale(20), :origin => @pB, :arrow_size => 16)
    end

    begin
      # 自機の表示
      @base.draw_triangle(@p0, :radius => @radius, :angle => @speed.angle)
      @base.vputs "p0", :vector => @p0

      # 自機の速度ベクトルの可視化(長さに意味はない)
      # @base.draw_vector(@speed.normalize.scale(50), :origin => @p0)
      @base.vputs "Speed Vector: #{@speed.to_a.inspect}"
    end

    begin
      # 線分ABの視覚化
      @base.draw_line2(@pA, @pB)
      @base.vputs "A", :vector => @pA
      @base.vputs "B", :vector => @pB

      # 線分ABの法線を見える化(長さに意味はない)
      @base.draw_vector(@normal.normalize.scale(64), :origin => Stylet::Vector.pos_vector_rate(@pA, @pB, 0.5), :arrow_size => 16)
    end
  end

  def screen_out?
    false
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << Ray.new(self, half_pos.clone)
    @cursor_vertex = 3
  end

  def update
    super if defined? super

    # 操作説明
    vputs "Z:drag X:angle C:ray++ V:ray--"
  end
end

App.main_loop
