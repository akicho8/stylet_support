# -*- coding: utf-8 -*-
#
# レイの当り判定
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ray
  def initialize(base, p0)
    @base = base

    @p0 = p0                               # 自機の位置ベクトル
    @dot_radius = 3                        # 点の大きさ
    @vertex = 32
    @vS = Stylet::Vector.new(0.84, -0.52).normalize  # 速度ベクトル

    # 線分AB
    @pA = @base.half_pos + Stylet::Vector.new(@base.half_x * 0.3, -@base.half_y * 0.5)
    @pB = @base.half_pos + Stylet::Vector.new(@base.half_x * 0.1, +@base.half_y * 0.5)

    mdoe_init
  end

  def mdoe_init
    if @base.ray_mode
      @radius = 1         # 自機の大きさ
    else
      @radius = 50        # 自機の大きさ
    end
    @vS = @vS.normalize.scale(@radius * 0.5) # 自機の速度ベクトル制限
  end

  def update
    # 操作
    begin
      # AとBで速度ベクトルの反映
      @p0 += @vS.scale(@base.button.btA.repeat_0or1) + @vS.scale(-@base.button.btB.repeat_0or1)
      # Cボタンおしっぱなし + マウスで自機位置移動
      if @base.button.btC.press?
        @p0 = @base.cursor.clone
      end
      # Dボタンおしっぱなし + マウスで自機角度変更
      if @base.button.btD.press?
        @vS = Stylet::Vector.sincos(@p0.angle_to(@base.cursor)) * @vS.radius
      end
    end

    begin
      # 法線取得
      @normal = @pA.normal(@pB).normalize
      # @base.vputs "Normal: #{@normal.length}"

      # 線分ABの法線を見える化(長さに意味はない)
      vN = @normal.normalize.scale(64)
      origin = Stylet::Vector.pos_vector_rate(@pA, @pB, 0.5)
      @base.draw_vector(vN, :origin => origin, :arrow_size => 8)
      @base.vputs "vN", :vector => origin + vN
    end

    # t と C1 の取得
    begin
      # スピードベクトルをt倍したら線に衝突するかを求める
      # 自機の原点・速度ベクトル・法線の原点(pAでもpBでもよい)・法線ベクトルを渡すと求まる
      @t1 = Stylet::Vector.collision_power_scale(@p0, @vS, @pA, @normal)

      # 裏面(通りすぎている) <= 0.0 < 衝突 <= 1.0 < 表面(まだあたっていない)
      @base.vputs "C1 t1: #{@t1} (#{ps_state(@t1)})"

      # スピードを t 倍したとき本当にラインに接触するのかを見える化
      # @base.draw_vector(@vS.scale(@t1), :origin => @p0)

      # 交差点の取得
      @pC1 = @p0 + @vS.scale(@t1)

      # 交差点の視覚化
      @base.draw_triangle(@pC1, :radius => @dot_radius, :angle => @vS.angle)
      @base.vputs "C1", :vector => @pC1

      # 線分ABの中に衝突しているか調べる方法
      # 内積の取得
      @ac1 = @pC1 - @pA
      @bc1 = @pC1 - @pB
      @ip1 = Stylet::Vector.inner_product(@ac1, @bc1)
      @base.vputs "C1 inner_product(AC1, BC1): #{@ip} (#{inner_product_state(@ip1)})"

      # 二つのベクトルがどちらを向いているか視覚化(お互いが衝突していたら線の中にいることがわかる)
      if @ac1.normalize.scale(20).x.nan?
        raise "Nan"
      end

      @base.draw_vector(@ac1.normalize.scale(20), :origin => @pA + @normal.scale(-20*1), :arrow_size => 8)
      @base.draw_vector(@bc1.normalize.scale(20), :origin => @pB + @normal.scale(-20*1), :arrow_size => 8)
    end

    # t2 と C2 の取得
    begin
      # 自機から面と垂直な線を出して面と交差するか調べる(ここが点の場合と違う)
      @vP = Stylet::Vector.sincos(@normal.__negative.angle).scale(@radius)
      @base.draw_vector(@vP, :origin => @p0)
      @base.vputs "vP", :vector => @vP + @p0

      # 自機の原点・速度ベクトル・法線の原点(pAでもpBでもよい)・法線ベクトルを渡すと求まる
      @t2 = Stylet::Vector.collision_power_scale(@p0, @vP, @pA, @normal)
      @base.vputs "C2 t2: #{@t2} (#{ps_state(@t2)})"

      # 交差点の取得
      @pC2 = @p0 + @vP.scale(@t2)

      # 交差点の視覚化
      @base.draw_triangle(@pC2, :radius => @dot_radius, :angle => @vP.angle)
      @base.vputs "C2", :vector => @pC2

      # 内積の取得
      @ac2 = @pC2 - @pA
      @bc2 = @pC2 - @pB
      @ip2 = Stylet::Vector.inner_product(@ac2, @bc2)
      @base.vputs "C2 inner_product(AC2, BC2): #{@ip2} (#{inner_product_state(@ip2)})"

      # 二つのベクトルがどちらを向いているか視覚化(お互いが衝突していたら線の中にいることがわかる)
      @base.draw_vector(@ac2.normalize.scale(20), :origin => @pA + @normal.scale(-20*2), :arrow_size => 8)
      @base.draw_vector(@bc2.normalize.scale(20), :origin => @pB + @normal.scale(-20*2), :arrow_size => 8)
    end

    # 線の表裏どちらにいるか。また衝突しているか？ (この時点では無限線)
    if @base.reflect_mode
      if @base.ray_mode && false
        # レイモードの反射は難しい
        # Zで通りすぎてXボタンでバックして再び突進すると線を通りすぎてしまう。
        # これは「移動距離 < 半径」の法則が慣りたってないから。
        # 半径を0.1などと考えて円にして反射させるのがいいのかも

        # _radius = 0.5
        #
        # if 0.0 < @t2 && @t2 <= 1.0 # めり込んでいる
        #   if @ip2 < 0 # 線の中で
        #     # 円を押し戻す
        #     @p0 = @pC2 + @normal.normalize.scale(_radius)
        #     @vS += @vS.reflect(@normal).scale(1.0)
        #   end
        # end
        #
        # # 速度制限(円が線から飛び出さないようにする)
        # if @vS.radius > _radius
        #   @vS = @vS.normalize.scale(_radius)
        # end

        # # Zで通りすぎてXボタンでバックして再び突進すると線を通りすぎてしまう。
        # # これは「移動距離 < 半径」の法則が慣りたってないから。
        # if 0.0 < @t && @t <= 1.0
        #   if @ip < 0
        #     @p0 = @pC1.clone
        #     # @p0 = @pC1 + @normal.normalize.scale(1.1)
        #     @vS += @vS.reflect(@normal)
        #   end
        # end
      else
        # レイの場合は半径がないので t1 と C1 を使っても同じ

        if 0.0 < @t2 && @t2 <= 1.0 # めり込んでいる
          if @ip2 < 0 # 線の中で
            # 円を押し戻す
            @p0 = @pC2 + @normal.normalize.scale(@radius)
            @vS += @vS.reflect(@normal).scale(1.0)
          end
        end

        # 速度制限(円が線から飛び出さないようにする)
        if @vS.radius > @radius
          @vS = @vS.normalize.scale(@radius)
        end

        # 点Aと点Bに円がめり込んでいたら押す
        [@pA, @pB].each do |pX|
          diff = @p0 - pX
          if diff.length < @radius
            @p0 = pX + diff.normalize.scale(@radius)
          end
        end
      end
    end

    begin
      if @base.ray_mode
        # 自機(ドット)の表示
        @base.draw_triangle(@p0, :radius => @dot_radius, :angle => @vS.angle)
      else
        # 自機(円)の表示
        @base.draw_circle(@p0, :radius => @radius, :vertex => @vertex, :angle => @vS.angle)
      end
      @base.vputs "p0", :vector => @p0

      # 自機の速度ベクトルの可視化(長さに意味はない)
      pS = @vS
      @base.draw_vector(pS, :origin => @p0)
      @base.vputs "vS", :vector => @p0 + pS
      @base.vputs "Speed Vector: #{@vS.to_a.inspect}"

      # 線分ABの視覚化
      @base.draw_line2(@pA, @pB)
      @base.vputs "A", :vector => @pA
      @base.vputs "B", :vector => @pB
    end
  end

  def screen_out?
    false
  end

  def ps_state(t)
    if t > 1.0
      "FACE"
    elsif 0.0 < t && t <= 1.0
      "COLLISION"
    else # t <= 0.0
      "REVERSE"
    end
  end

  #   1. ←← or →→ 正 (0.0 < v)   お互いだいたい同じ方向を向いている
  #   2. →←         負 (v   < 0.0) お互いだいたい逆の方向を向いている
  #   3. →↓ →↑    零 (0.0)       お互いが直角の関係
  def inner_product_state(v)
    if v < 0
      "IN"
    else
      "OUT"
    end
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :ray_mode
  attr_reader :reflect_mode

  def before_main_loop
    super if defined? super

    @ray_mode = true           # true:ドット false:円
    @reflect_mode = true       # true:反射する

    @objects << Ray.new(self, half_pos.clone)
    @cursor_vertex = 3
  end

  def update
    super if defined? super

    if key_down?(SDL::Key::A)
      @ray_mode = !@ray_mode
      @objects.first.mdoe_init
    end
    if key_down?(SDL::Key::S)
      @reflect_mode = !@reflect_mode
    end

    # 操作説明
    vputs "A:ray=#{@ray_mode} S:reflect=#{@reflect_mode}"
    vputs "Z:ray++ X:ray-- C:drag V:angle"
  end
end

App.main_loop
