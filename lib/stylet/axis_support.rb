# -*- coding: utf-8 -*-
#
# レバーの状態から方向を返す便利メソッド
#

module Stylet
  module AxisSupport
    extend self

    # レバーの状態から8方向の番号インデックスに変換
    #        [U]
    #         6
    #       5   7
    #  [L]4       0[R]
    #       3   1
    #         2
    #        [D]
    def axis_angle_index(axis)
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

    # 8方向レバーの状態から一周を1.0としたときの方向を返す
    #            [U]
    #           0.750
    #        0.625 0.875
    #   [L] 0.500   0.000 [R]
    #        0.375 0.125
    #           0.250
    #            [D]
    def axis_angle(axis)
      if dir = axis_angle_index(axis)
        1.0 / 8 * dir
      end
    end
  end
end

if $0 == __FILE__
  require_relative "fee"
  p Stylet::Fee.angle_at(0)
end
