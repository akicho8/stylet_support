# -*- coding: utf-8 -*-
#
# デモ - かごの中で球が転がある
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  REFLECT_RATIO = 1.0 # 反発係数

  attr_accessor :pos            # 中心点
  attr_accessor :speed          # 速度
  attr_reader :radius           # 円の半径
  attr_reader :mass             # 質量

  def initialize(win, scene, index)
    @win = win
    @scene = scene

    @pos = @win.rect.center.clone                                                           # 中心点
    @speed = Stylet::Vector.new(Stylet::Etc.wide_rand(2.0), Stylet::Etc.range_rand(-6, -8)) # 速度ベクトル
    @gravity = Stylet::Vector.new(0, 0.20)                                                  # 重力
    if index < 4
      @radius = 8 + ((index + 2) ** 2)                                                      # 半径
    else
      @radius = Stylet::Etc.range_rand(8, 20)                                               # 半径
    end
    @mass = @radius ** 2                                                                    # 質量は面積と比例することにする(PI*r二乗)
    @vertex = Stylet::Etc.range_rand(16, 16).to_i                                           # 何角形か？
  end

  #
  # 線分 pA pB との当たり判定
  #
  def collide_circle_vs_line(pA, pB, options = {})
    # 点Aと点Bに円がめり込んでいたら押す
    [pA, pB].each do |pX|
      diff = @pos - pX
      if diff.length > 0
        if diff.length < @radius
          @pos = pX + diff.normalize.scale(@radius)
          @speed = diff.normalize * @speed.length
        end
      end
    end

    # 法線(正規化済み)
    normal = pA.normal(pB).normalize
    # @win.draw_line(pA, pA + normal.scale(30))

    # t と C の取得
    begin
      # 自機から面と垂直な線を出して面と交差するか調べる
      @vP = Stylet::Vector.angle_at(normal.reverse.angle).scale(@radius)

      # 自機の原点・速度ベクトル・法線の原点(pAでもpBでもよい)・法線ベクトルを渡すと求まる
      @t = Stylet::Vector.collision_power_scale(@pos, @vP, pA, normal)

      # 交差点の取得
      @pC = @pos + @vP.scale(@t)

      # 内積の取得
      ac = @pC - pA
      bc = @pC - pB
      if ac.nonzero? && bc.nonzero?
        @ip2 = Stylet::Vector.inner_product(ac, bc)
      else
        raise
      end
    end

    # 線の表裏どちらにいるか。また衝突しているか？ (この時点では無限線)

    f = false
    if options[:ground]
      f = @t <= 1.0 # めり込んでいる or 通り過ぎている
    else
      f = 0.0 < @t && @t <= 1.0 # めり込んでいる(これだと線を飛び越えてしまう)
    end
    if f
      if @ip2 < 0 # 線の中で
        # 円を押し戻す
        @pos = @pC + normal * @radius
        @speed += @speed.reflect(normal)
      end
    end

    # 速度制限(円が線から飛び出さないようにする)
    speed_limit!
    # if @speed.length > @radius
    #   @speed = @speed.normalize.scale(@radius)
    # end
  end

  def self.collide_circle_vs_circle(oA, oB)
    pA = oA.pos
    pB = oB.pos
    sA = oA.speed
    sB = oB.speed
    amass = oA.mass
    bmass = oB.mass

    diff = pB - pA
    rdiff = (oA.radius + oB.radius) - diff.length
    # Stylet::Base.instance.vputs rdiff

    # ここは完全に重なっている。物理的にはこうならないので左右に移動させる
    if diff.length.zero?
      arrow = Stylet::Vector.nonzero_random_new
      pA -= arrow * oA.radius
      pB += arrow * oB.radius
      oA.pos = pA
      oB.pos = pB
      return true
    end

    # @win.vputs "length=#{diff.length}"
    # @win.vputs "rdiff=#{rdiff}"

    # if diff.length.zero?
    #   return
    # end

    # # AとBをお互い離す
    # if @win.reflect_mode == "move"
    #   if rdiff > 0
    #     pA -= diff.normalize * rdiff / 2
    #     pB += diff.normalize * rdiff / 2
    #   end
    # end

    # 反射する
    if rdiff > 0

      # 反射するモードでもいったんお互いを引き離さないと絡まってしまう
      pA -= diff.normalize * rdiff * 0.5
      pB += diff.normalize * rdiff * 0.5

      # (am) 円Ａから円Ｂへ移動運動を発生させるベクトル
      # (ar) 円Ａから円Ｂへ回転運動を発生させるベクトル
      # (bm) 円Ｂから円Ａへ移動運動を発生させるベクトル
      # (br) 円Ｂから円Ａへ回転運動を発生させるベクトル

      # 速度ベクトルを重心方向と垂直な方向に分離する
      _denominator = (diff.x ** 2 + diff.y ** 2)

      # A
      # A→B 回転運動
      t = -(diff.x * sA.x + diff.y * sA.y) / _denominator
      ar = sA + diff.scale(t)

      # A→B 移動運動
      t = -(-diff.y * sA.x + diff.x * sA.y) / _denominator
      am = Stylet::Vector.new
      am.x = sA.x - diff.y * t
      am.y = sA.y + diff.x * t

      # B
      # B→A 回転運動
      t = -(diff.x * sB.x + diff.y * sB.y) / _denominator
      br = sB + diff.scale(t)

      # B→A 移動運動
      t = -(-diff.y * sB.x + diff.x * sB.y) / _denominator
      bm = Stylet::Vector.new
      bm.x = sB.x - diff.y * t
      bm.y = sB.y + diff.x * t

      # x 方向と y 方向それぞれの衝突後の速度を計算する
      ad = Stylet::Vector.new
      bd = Stylet::Vector.new
      ad.x = (amass * am.x + bmass * bm.x + bm.x * REFLECT_RATIO * bmass - am.x * REFLECT_RATIO * bmass) / (amass + bmass)
      bd.x = - REFLECT_RATIO * (bm.x - am.x) + ad.x
      ad.y = (amass * am.y + bmass * bm.y + bm.y * REFLECT_RATIO * bmass - am.y * REFLECT_RATIO * bmass) / (amass + bmass)
      bd.y = - REFLECT_RATIO * (bm.y - am.y) + ad.y

      # 回転運動を発生させるベクトルを加算して衝突後の速度を計算
      sA.x = ad.x + ar.x
      sA.y = ad.y + ar.y
      sB.x = bd.x + br.x
      sB.y = bd.y + br.y

      oA.pos = pA
      oB.pos = pB
      oA.speed = sA
      oB.speed = sB

      oA.speed_limit!
      oB.speed_limit!

      # pA += sA
      # pB += sB
      true
    else
      false
    end
  end

  def speed_limit!(r = 1.0)
    # 速度制限(円が線から飛び出さないようにする)
    if @speed.length > (@radius * r)
      @speed = @speed.normalize.scale(@radius * r)
    end
  end

  def speed_limit2!(v)
    # 速度制限(円が線から飛び出さないようにする)
    if @speed.length > v
      @speed = @speed.normalize.scale(v)
    end
  end

  def update
    # 操作
    begin
      # AとBで速度ベクトルの反映
      @pos += @speed.scale(@win.button.btA.repeat_0or1) + @speed.scale(-@win.button.btB.repeat_0or1)
      # Cボタンおしっぱなし + マウスで自機位置移動
      if @win.button.btC.press?
        @pos = @win.cursor.clone
      end
      # Dボタンおしっぱなし + マウスで自機角度変更
      if @win.button.btD.press?
        if @win.cursor != @pos
          @speed = (@win.cursor - @pos).normalize * @speed.length.round
        end
      end
    end

    @speed += @gravity
    # speed_limit2!(10.0)

    @pos += @speed

    # 自機(円)の表示
    @win.draw_circle(@pos, :radius => @radius, :vertex => @vertex, :angle => @speed.angle)
  end
end

class Scene
  def initialize(win)
    @win = win
    @balls = Array.new(5){|i|Ball.new(@win, self, i)}
    @count = 0
    @center = @win.rect.center
  end

  def update
    # # Aボタンおしっぱなし + マウスで自機角度変更
    # if @win.button.btA.press?
    #   @center = @win.cursor.clone
    #   # if @win.cursor != @center
    #   #   @speed = (@win.cursor - @pos).normalize * @speed.length
    #   # end
    # end

    _count = @count

    # 線の準備
    @lines = []
    n = 5
    n.times{|i|
      @lines << @center + Stylet::Vector.angle_at((1.0 / 128 * _count) + 1.0 / n * i) * @win.rect.h * 0.45
    }

    # 線の準備
    @lines2 = []
    n = 3
    n.times{|i|
      @lines2 << @center + Stylet::Vector.angle_at((1.0 / 512 * _count) + 1.0 / n * i) * @win.rect.h * 0.1
    }

    # 円と円の当たり判定
    @balls.each{|ball1|
      (@balls - [ball1]).each{|ball2|
        Ball.collide_circle_vs_circle(ball1, ball2)
      }
    }

    # 円と線の当たり判定
    @lines.each_index{|i|
      a = @lines[i]
      b = @lines[i.next.modulo(@lines.size)]
      @balls.each{|ball|
        ball.collide_circle_vs_line(a, b, :ground => true)
      }
    }

    # 円と線の当たり判定(中央の物体)
    @lines2.each_index{|i|
      a = @lines2[i]
      b = @lines2[i.next.modulo(@lines2.size)]
      @balls.each{|ball|
        ball.collide_circle_vs_line(b, a)
      }
    }

    # 線の描画
    @lines.each_index{|i|
      a = @lines[i]
      b = @lines[i.next.modulo(@lines.size)]
      @win.draw_line(a, b)
    }

    # 線の描画
    @lines2.each_index{|i|
      a = @lines2[i]
      b = @lines2[i.next.modulo(@lines2.size)]
      @win.draw_line(a, b)
    }

    # 球の描画
    @balls.each{|ball|ball.update}

    @count += 1
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << Scene.new(self)
  end

  def update
    super if defined? super

    #    Stylet::Base.instance.vputs "foo"

    # 操作説明
    # vputs "Z:ray++ X:ray-- C:drag V:angle"
  end
end

App.main_loop
