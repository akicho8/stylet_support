# -*- coding: utf-8 -*-
module Stylet
  #
  # 二次元座標
  #
  #   単に x y のメンバーがあればいいとき用
  #
  Point = Struct.new(:x, :y)

  #
  # ベクトル
  #
  class Vector < Point
    def +(target)
      self.class.new(x + target.x, y + target.y)
    end

    def -(target)
      self.class.new(x - target.x, y - target.y)
    end

    #
    # 相手との距離を取得
    #
    #   三平方の定理
    #
    #             p2
    #        c     b
    #     p0   a  p1
    #
    #     c = sqrt(a * a + b * b)
    #
    def distance(target)
      dx = (x - target.x).abs
      dy = (y - target.y).abs
      Math.sqrt((dx ** 2) + (dy ** 2))
    end

    #
    # 相手の方向を取得
    #
    def angle(target)
      Stylet::Fee.angle(x, y, target.x, target.y)
    end
  end
end

if $0 == __FILE__
  p0 = Stylet::Vector.new(1, 1)
  p1 = Stylet::Vector.new(1, 1)
  p(p0 == p1)
  p2 = p0 + p1
  p p2
end
