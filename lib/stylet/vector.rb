# -*- coding: utf-8 -*-
module Stylet
  Point = Struct.new(:x, :y)
  Point3 = Struct.new(:x, :y, :z)

  class ZeroVectorError < StandardError; end

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
            self.class.new(*members.collect{|m|Float(public_send(m)).public_send(attr[:sym], o.public_send(m))})
          end
          define_method("#{attr[:name]}!") do |*args|
            instance_copy_from(public_send(attr[:name], *args))
          end
          alias_method attr[:sym], attr[:name]
        }

        [
          {:name => :scale, :sym => :*},
          {:name => :div,   :sym => :/},
        ].each{|attr|
          define_method(attr[:name]) do |o|
            self.class.new(*members.collect{|m|Float(public_send(m)).public_send(attr[:sym], o)})
          end
          define_method("#{attr[:name]}!") do |*args|
            instance_copy_from(public_send(attr[:name], *args))
          end
          alias_method attr[:sym], attr[:name]
        }

        alias mul scale
        alias mul! scale!

        [
          {:name => :round},
        ].each{|attr|
          define_method(attr[:name]) do
            self.class.new(*members.collect{|m|Float(public_send(m)).public_send(attr[:name])})
         end
          define_method("#{attr[:name]}!") do |*args|
            instance_copy_from(public_send(attr[:name], *args))
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
          raise ZeroVectorError if obj.zero?
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
      #   名前はライブラリによって異なる
      #     dot
      #     inner_product
      #     product
      #
      def inner_product(a, b)
        a = a.normalize
        b = b.normalize
        members.collect{|m|a.public_send(m) * b.public_send(m)}.reduce(:+) || 0 # a.x * b.x + a.y * b.y
      end
    end

    module InstanceMethods
      ##--------------------------------------------------------------------------------
      # 汎用
      #
      # def __send(method, *args)
      #   self.class.new(*members.collect{|m|Float(public_send(m)).public_send(method, *args)})
      # end
      #
      # def __send!(method, *args)
      #   instance_copy_from(__send(method, *args))
      # end

      def instance_copy_from(other)
        tap do
          members.each{|m|public_send("#{m}=", other.public_send(m))} # self.x, self.y = obj.x, obj.y
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
        raise ZeroVectorError if zero?
        c = length
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

      alias -@ reverse

      # 内積
      def inner_product(other)
        self.class.public_send(__method__, self, other)
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

      # 0ベクトルか？
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
    #   cursor += Stylet::Fee.angle_at(dir) * speed
    #
    def self.angle_at(x, y = x)
      new(Fee.cos(x), Fee.sin(y))
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
    #
    # 式の意味がまだ理解できてない
    #
    def self.collision_power_scale(p, s, a, n)
      d = -(a.x * n.x + a.y * n.y)
      -(n.x * p.x + n.y * p.y + d) / (n.x * s.x + n.y * s.y)
    end

    # 法線ベクトルの取得(方法1)
    # どう見ても遅い
    def slowly_normal(t)
      a = angle(t) + Fee.r90
      Vector.new(Fee.cos(a), Fee.sin(a))
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
      Fee.angle(0, 0, x, y)
    end

    #
    # 線分 A B の距離 1.0 をしたとき途中の位置ベクトルを取得
    #
    #   a と b の位置が同じ場合いろいろおかしくなる
    #
    def self.pos_vector_rate(a, b, rate)
      a + angle_at(a.angle_to(b)) * (a.distance_to(b) * rate) # FIXME: ダメなコード
    end

    #
    # 指定の角度だけ回転する
    #
    #   自分が最初に考えた方法
    #
    def rotate(a)
      self.class.angle_at(angle + a) * length
    end

    def rotate!(*args)
      instance_copy_from(rotate(*args))
    end

    #
    # 指定の角度だけ回転する(方法2)
    #
    #   他のいくつかのライブラリで使われている方法。
    #   こっちの方が速そうだけど意味がよくわからない。
    #
    def rotate2(a)
      tx = (x * Fee.cos(a)) - (y * Fee.sin(a))
      ty = (x * Fee.sin(a)) + (y * Fee.cos(a))
      self.class.new(tx, ty)
    end

    def rotate2!(*args)
      instance_copy_from(rotate2(*args))
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
  p -Stylet::Vector.new(3, 4)

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
