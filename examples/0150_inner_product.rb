# -*- coding: utf-8 -*-
#
# 内積
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class App < Stylet::Base
  include Helper::TriangleCursor

  def update
    super if defined? super

    # ベクトルAの方向
    @hour ||= 3
    @hour += (@button.btA.repeat - @button.btB.repeat)

    @vA = Stylet::Vector.sincos(Stylet::Fee.clock(@hour)).scale(half_y * 0.8)    # ベクトルAはキーボードで移動できる
    @vB = Stylet::Vector.sincos(srect.center.angle_to(@cursor)).scale(half_y * 0.8)  # ベクトルBはマウスの方を向く

    vputs ["Inner Product: ", Stylet::Vector.inner_product(@vA, @vB)] # 内積が求まる

    # ベクトル可視化
    draw_vector(@vA, :origin => srect.center)
    draw_vector(@vB, :origin => srect.center)

    vputs "Z:vA++ X:vA--"
  end
end

App.main_loop
