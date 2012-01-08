# -*- coding: utf-8 -*-
#
# 放物線デモ
#
# ・Zでスピード反転
# ・Xでスピード二倍
# ・Cでマウスの位置にセット
# ・Vで速度ベクトルの向きをマウスの向きへ
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Ball
  def initialize(win)
    @win = win

    @vertex = 3 + rand(3)           # 物体は何角形か
    @radius = 2 + rand(24)          # 物体の大きさ
    @arrow = rand(2).zero? ? 1 : -1 # どっち向きに回転するか

    @pos = Stylet::Vector.new(@win.srect.center.x, @win.srect.max_y + @radius * 2)             # 物体初期位置
    @speed = Stylet::Vector.new(Stylet::Etc.wide_random(3.0), Stylet::Etc.range_random(-8, -16)) # 速度ベクトル
    @gravity = Stylet::Vector.new(0, 0.2)                                                        # 重力
  end

  def update
    # 操作
    begin
      # Aボタンでスピード反転
      if @win.button.btA.trigger?
        @speed = @speed.scale(-1)
      end

      # Bボタンでスピード2倍
      if @win.button.btB.trigger?
        @speed = @speed.scale(2)
      end

      # Cボタンおしっぱなし + マウスで位置移動
      if @win.button.btC.press?
        @pos = @win.cursor.clone
      end

      # Dボタンおしっぱなし + マウスで角度変更
      if @win.button.btD.press?
        if @win.cursor != @pos
          # @speed = (@win.cursor - @pos).normalize * @speed.length
          @speed = (@win.cursor - @pos).normalize * @speed.length
        end
      end
    end

    @speed += @gravity # 加速
    @pos += @speed     # 進む

    # 落ちてしまったら死ぬ
    @max = @win.srect.max_y + @radius * 2
    if @pos.y > @max && @speed.y >= 1
      @win.objects.delete(self)
    end

    @win.draw_circle(@pos, :radius => @radius, :vertex => @vertex, :angle => 1.0 / 256 * (@speed.length + @win.count) * @arrow)
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @cursor_display = false
  end

  def update
    super if defined? super
    if @count.modulo(4).zero?
      @objects << Ball.new(self)
    end
  end
end

App.main_loop
