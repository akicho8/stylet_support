# -*- coding: utf-8 -*-
#
# 円の移動の定石
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Scene
  def initialize(base)
    @base = base

    @pA = @base.half_pos.clone
    @sA = Stylet::Vector.sincos(Stylet::Fee.clock(8))

    @radius = 50
    @vertex = 32
  end

  def update
    # 操作
    begin
      # AとBで速度ベクトルの反映
      @pA += @sA.scale(@base.button.btA.repeat_0or1) + @sA.scale(-@base.button.btB.repeat_0or1)
      # Cボタンおしっぱなし + マウスで自機位置移動
      if @base.button.btC.press?
        @pA = @base.cursor.clone
      end
      # Dボタンおしっぱなし + マウスで自機角度変更
      if @base.button.btD.press?
        if @base.cursor != @pA
          @sA = (@base.cursor - @pA).normalize * @sA.radius
        end
      end
    end

    @base.draw_circle(@pA, :vertex => @vertex, :radius => @radius)
    @base.draw_vector(@sA.scale(@radius), :origin => @pA)
  end

  def screen_out?
    false
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

    @objects << Scene.new(self)
    @cursor_vertex = 3
  end

  def update
    super if defined? super

    if key_down?(SDL::Key::A)
      @ray_mode = !@ray_mode
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
