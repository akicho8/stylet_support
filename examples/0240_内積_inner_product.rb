# -*- coding: utf-8 -*-
#
# 内積
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Scene
  def initialize(win)
    @win = win
    @hour ||= 3
  end

  def update
    # ベクトルAの方向
    @hour += (@win.button.btA.repeat - @win.button.btB.repeat)

    vA = Stylet::Vector.angle_at(Stylet::Fee.clock(@hour)).scale(@win.rect.hy * 0.8)    # ベクトルAはキーボードで移動できる
    vB = Stylet::Vector.angle_at(@win.rect.center.angle_to(@win.cursor)).scale(@win.rect.hy * 0.8)  # ベクトルBはマウスの方を向く

    @win.vputs ["Inner Product: ", Stylet::Vector.inner_product(vA, vB)] # 内積が求まる

    # ベクトル可視化
    @win.draw_vector(vA, :origin => @win.rect.center)
    @win.draw_vector(vB, :origin => @win.rect.center)

    @win.vputs "Z:vA++ X:vA--"
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << Scene.new(self)
  end
end

App.main_loop
