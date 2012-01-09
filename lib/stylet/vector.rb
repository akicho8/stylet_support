# -*- coding: utf-8 -*-
#
# 速度ベクトルの向きを取得するには？
#
#   speed.angle
#
# 速度ベクトルを45度傾けるには？
#
#   speed += Stylet::Vector.sincos(Stylet::Fee.r45) * speed.length
#
# p0の速度ベクトルをマウスの方向に設定するには？
#
#   speed = Stylet::Vector.sincos(p0.angle_to(win.mouse_vector)) * speed.length
#
# 円の速度制限をするには？(円が線から飛び出さないようにするときに使う)
#
#   if speed.length > radius
#     speed = speed.normalize.scale(radius)
#   end
#
# 線分ABの中央の位置を取得するには？
#
#   half_ab = pA + Stylet::Vector.sincos(pA.angle_to(pB)) * (pA.distance_to(pB) / 2)
#
#   Vector#pos_vector_rate(pA, pB, rate)
#
# 円(c,r)が点(dot)にめりこんだとき、点(dot)から円を押し出すには？
#
#   良い例
#
#     diff = c - dot
#     if diff.length < r
#       c = dot + diff.normalize * r
#     end
#
#   悪い例
#
#     if p0.distance_to(p1) < r
#       p0 = p1 + Stylet::Vector.sincos(p1.angle_to(p0)) * r
#     end
#
# 円Aと円Bをお互い離すには？
#
#   diff = b - a
#   rdiff = r * 2 - diff.length
#   if rdiff > 0
#     a -= diff.normalize * rdiff / 2
#     b += diff.normalize * rdiff / 2
#   end
#
# 正規化とは斜めの辺の長さを 1.0 にすること
#
#   v.normalize.length #=> 1.0
#
# A B C D ボタンとカーソルで操作できるとき物体(pA)と速度(speed)をコントロールするときの定石は？
#
#   # AとBで速度ベクトルの反映
#   @pA += @speed.scale(@win.button.btA.repeat_0or1) + @speed.scale(-@win.button.btB.repeat_0or1)
#   # @pA += @speed.scale(@win.button.btA.repeat) + @speed.scale(-@win.button.btB.repeat) # 加速したいとき
#
#   # Cボタンおしっぱなし + マウスで自機位置移動
#   if @win.button.btC.press?
#     @pA = @win.cursor.clone
#   end
#
#   # Dボタンおしっぱなし + マウスで自機角度変更
#   if @win.button.btD.press?
#     if @win.cursor != @pA
#       # @speed = Stylet::Vector.sincos(@pA.angle_to(@win.cursor)) * @speed.radius # ← よくある間違い
#       @speed = (@win.cursor - @pA).normalize * @speed.length # @speed.length の時点で桁溢れで削れるのが嫌なら length.round とする手もあり
#     end
#   end
#
# 円が完全に重なっている場合、ランダムに引き離す定石
#
#   diff = a - b
#   if diff.length.zero?
#     arrow = Stylet::Vector.nonzero_random_new
#     a -= arrow * ar
#     b += arrow * br
#   end
#
#
# 参考URL
# ・基礎の基礎編その１　内積と外積の使い方 http://marupeke296.com/COL_Basic_No1_InnerAndOuterProduct.html
# ・内積が角度になる証明 http://marupeke296.com/COL_Basic_No1_DotProof.html
# ・衝突判定編 http://marupeke296.com/COL_main.html
# ・その５　反射ベクトルと壁ずりベクトル http://marupeke296.com/COL_Basic_No5_WallVector.html
#
module Stylet
  Point = Struct.new(:x, :y)
  Point3 = Struct.new(:x, :y, :z)

  module BasicVector
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        [
          {:name => :add, :sym => :+},
          {:name => :sub, :sym => :-},
        ].each{|attr|
          define_method(attr[:name]) do |o|
            self.class.new(*members.collect{|m|Float(send(m)).send(attr[:sym], o.send(m))})
          end
          define_method("#{attr[:name]}!") do |*args|
            instance_copy_from(send(attr[:name], *args))
          end
          alias_method attr[:sym], attr[:name]
        }

        [
          {:name => :scale, :sym => :*},
        ].each{|attr|
          define_method(attr[:name]) do |o|
            self.class.new(*members.collect{|m|Float(send(m)).send(attr[:sym], o)})
          end
          define_method("#{attr[:name]}!") do |*args|
            instance_copy_from(send(attr[:name], *args))
          end
          alias_method attr[:sym], attr[:name]
        }

        [
          {:name => :round},
        ].each{|attr|
          define_method(attr[:name]) do
            self.class.new(*members.collect{|m|Float(send(m)).send(attr[:name])})
          end
          define_method("#{attr[:name]}!") do |*args|
            instance_copy_from(send(attr[:name], *args))
          end
        }
      end
    end

    module ClassMethods
      def random(r = 1.0)
        new(*members.collect{Etc.wide_rand(r)})
      end

      def safe_new(*args)
        new(*args).tap do |obj|
          if obj.zero?
            p [self, caller]
            raise "ベクトル0はNaNになるので入れんな"
          end
        end
      end

      # 1.0 と -1.0 で構成したランダム値
      def nonzero_random_new
        new(*members.collect{Etc.nonzero_random})
      end

      # 内積
      #
      #   2つの単位ベクトルの平行の度合いを表わす
      #   ・ベクトルは正規化しておくこと
      #   ・引数の順序は関係なし
      #
      #   a が右向きのとき b のそれぞれの向きによって以下の値になる
      #              0.0
      #         -0.5  │   0.5
      #               │
      #      -1.0 ──＋── 1.0 (a)
      #               │
      #         -0.5  │   0.5
      #              0.0
      #
      #   これからわかること
      #   1. ←← or →→ 正 (0.0 < v)   お互いだいたい同じ方向を向いている
      #   2. →←         負 (v   < 0.0) お互いだいたい逆の方向を向いている
      #   3. →↓ →↑    零 (0.0)       お互いが直角の関係
      #
      #   計算式
      #
      #     a = a.normalize
      #     b = b.normalize
      #     a.x * b.x + a.y * b.y
      #
      def inner_product(a, b)
        a = a.normalize
        b = b.normalize
        members.collect{|m|a.send(m) * b.send(m)}.inject(0, &:+) # a.x * b.x + a.y * b.y
      end
    end

    module InstanceMethods
      ##--------------------------------------------------------------------------------
      # 汎用
      #
      # def __send(method, *args)
      #   self.class.new(*members.collect{|m|Float(send(m)).send(method, *args)})
      # end
      #
      # def __send!(method, *args)
      #   instance_copy_from(__send(method, *args))
      # end

      def instance_copy_from(other)
        tap do
          members.each{|m|send("#{m}=", other.send(m))} # self.x, self.y = obj.x, obj.y
        end
      end

      #
      # 正規化
      #
      #   p = Vector.new(2, 3)
      #   (p - p).normalize
      #   とするとベクトル 0 ができて n / 0.0 で NaN になるので注意
      #
      def normalize
        c = length

        # if c > 0                # これは ZeroDivisionError を出さないためのものなので 0, 0 のベクトルがなければ不要
        #   c = 1.0 / c
        # end

        # これはダメ。ベクトルが消えてしまう
        # if c.zero?
        #   return Vector.new(0, 0)
        # end

        if c.zero?
          warn [x, y].inspect
          raise ZeroDivisionError
        end

        self.class.safe_new(*values.collect{|v|Float(v) / c})
      end

      def normalize!
        instance_copy_from(normalize)
      end

      # 距離の取得
      #
      #   三平方の定理より
      #
      #             p2
      #        c     b
      #     p0   a  p1
      #
      #     c = sqrt(a * a + b * b)
      #
      #   x.abs ** 2 のように書いてたけど必要なかった
      #   次のようにマイナスでも二回掛けると必ず正になるので
      #     -2 * -2 = 4
      #      2 *  2 = 4
      #
      #   当たり判定を次のように行なっている場合、
      #     sx = mx - ax
      #     sy = my - ay
      #     if sqrt(sx * sx + sy * sy) < r
      #     end
      #
      #   次のように sqrt を外すことができる
      #     if (sx * sx + sy * sy) < (r ** 2)
      #     end
      #
      def length
        Math.sqrt(values.collect{|v|v ** 2}.inject(0, &:+)) # Math.sqrt(x ** 2 + y ** 2)
      rescue Errno::EDOM => error
        warn values.inspect
        warn "(p - p).length と書いているコードがあるはず。それをやると sqrt(0) になるので if p != p を入れてくれ"
        raise error
      end

      #
      # 反対方向のベクトルを返す
      #
      def reverse
        self.class.new(*values.collect{|v|-v})
      end

      # 内積
      def inner_product(other)
        self.class.send(__method__, self, other)
      end

      #
      # 相手との距離を取得
      #
      def distance_to(target)
        (target - self).length
      end

      # FIXME: それぞれのクラスに書くべきだろうか
      def to_2dv
        Vector.new(*values.take(2))
      end

      def to_3dv
        Vector3.new(*(values + [0]).take(3))
      end

      # ゼロベクトルか？
      def zero?
        values.all?{|v|v.zero?}
      end

      def nonzero?
        !zero?
      end
    end
  end

  #
  # ベクトル
  #
  # 移動制限のつけ方
  #
  #   if vec.length > n
  #     vec.normalize.scale(n)
  #   end
  #
  # 摩擦
  #
  #   vec.scale(0.9)
  #
  class Vector < Point
    include BasicVector

    # 方向ベクトル
    #
    #   これを使うと次のように簡単に書ける
    #   cursor.x += Stylet::Fee.cos(dir) * speed
    #   cursor.y += Stylet::Fee.sin(dir) * speed
    #     ↓
    #   cursor += Stylet::Fee.sincos(dir) * speed
    #
    def self.sincos(x, y = x)
      new(Stylet::Fee.cos(x), Stylet::Fee.sin(y))
    end

    # 反射ベクトルの取得
    #
    #   s: スピードベクトル
    #   n: 法線ベクトル
    #
    #   定石
    #     速度ベクトル += 速度ベクトル.reflect(法線ベクトル).scale(反射係数)
    #     @speed += @speed.reflect(@normal).scale(0.5)
    #
    #   反射係数
    #     ×1.5: 謎の力によってありえない反射をする
    #     ◎1.0: 摩擦なし(標準)
    #     ◎0.8: 少しす滑る
    #     ○0.6: かなり滑ってほんの少しだけ反射する
    #     ○0.5: 線に沿って滑る
    #     ×0.4: 線にわずかにめり込んだまま滑る
    #     ○0.0: 線に沿って滑る(突き抜けるかと思ったけど滑る)
    #
    #   hakuhin.jp/as/collide.html#COLLIDE_02 の方法だと x + t * n.x * 2.0 * 0.8 と一気に書いていたけど
    #   メソッド化するときには分解した方がわかりやすそうなのでこうした。
    #
    #   その５ 反射ベクトルと壁ずりベクトル
    #   http://marupeke296.com/COL_Basic_No5_WallVector.html
    #
    def reflect(n)
      slide(n) * 2.0
    end

    # スライドベクトル
    #
    # self: スピードベクトル
    #    n: 法線ベクトル
    #
    def slide(n)
      t = -(n.x * x + n.y * y) / (n.x ** 2 + n.y ** 2)
      n * t
    end

    #
    #    p: 現在地点
    #    s: スピードベクトル
    #    a: 線の片方
    #    n: 法線ベクトル
    #
    # としたら何倍したら線にぶつかるか
    def self.collision_power_scale(p, s, a, n)
      d = -(a.x * n.x + a.y * n.y)
      -(n.x * p.x + n.y * p.y + d) / (n.x * s.x + n.y * s.y)
    end

    # 法線ベクトルの取得(方法1)
    # どう見ても遅い
    def slowly_normal(t)
      a = angle(t) + Stylet::Fee.r90
      Vector.new(Stylet::Fee.cos(a), Stylet::Fee.sin(a))
    end

    # 法線ベクトルの取得(方法2)
    def normal(t)
      dx = t.x - x
      dy = t.y - y
      Vector.new(-dy, dx)
    end

    #
    # 相手の方向を取得
    #
    def angle_to(target)
      (target - self).angle
    end

    #
    # ベクトルから角度に変換
    #
    #   Math.atan2(y, x) * 180 / Math.PI
    #
    def angle
      Stylet::Fee.angle(0, 0, x, y)
    end

    #
    # 線分 A B の距離 1.0 をしたとき途中の位置ベクトルを取得
    #
    def self.pos_vector_rate(a, b, rate)
      a + Stylet::Vector.sincos(a.angle_to(b)) * (a.distance_to(b) * rate) # FIXME: ダメなコード
    end

    def rotate(a)
      Stylet::Vector.sincos(angle + a) * length
    end

    def rotate!(*args)
      instance_copy_from(rotate(*args))
    end
  end

  class Vector3 < Point3
    include BasicVector
  end
end

if $0 == __FILE__
  p0 = Stylet::Vector.new(1, 1)
  p1 = Stylet::Vector.new(1, 1)
  p(p0 + p1)
  p(p0.add(p1))
  p(p0.add!(p1))
  p(p0)
  p(Stylet::Vector.new(3, 4).length)
  p(Stylet::Vector.new(3, 4).normalize.scale(5))

  # p0 = Stylet::Vector.new(1, 1)
  # p1 = Stylet::Vector.new(1, 1)
  # p(p0 == p1)
  # p p0
  # p p0 + p1
  # p p0.add(p1)
  # p p0
  # p p0.add!(p1)
  # p p0
  #
  # p0 = Stylet::Vector.new(0, 0)
  # p p0.normalize
end
