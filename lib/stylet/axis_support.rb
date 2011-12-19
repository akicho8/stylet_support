# -*- coding: utf-8 -*-

module Stylet
  module AxisSupport
    extend self

    #
    # レバーの状態から8方向の番号インデックスに変換
    #
    def direction(axis)
      dir = nil
      if axis.up.press?
        if axis.right.press?
          dir = 7
        elsif axis.left.press?
          dir = 5
        else
          dir = 6
        end
      elsif axis.down.press?
        if axis.right.press?
          dir = 1
        elsif axis.left.press?
          dir = 3
        else
          dir = 2
        end
      elsif axis.right.press?
        dir = 0
      elsif axis.left.press?
        dir = 4
      end
      dir
    end

    #
    # レバーの状態から一周を1.0としたときの方向を返す
    #
    def directionf(axis)
      if dir = direction(axis)
        1.0 / 8 * dir
      end
    end
  end
end
