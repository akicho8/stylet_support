# -*- coding: utf-8 -*-
#
# ブロックとブロックの当たり判定
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Scene
  def initialize(win)
    @win = win

    # A
    @pA = @win.srect.half_pos.clone                           # 点
    @rA = Stylet::Rect.new(-20, -20, 20*2, 20*2)              # 大きさ
    @sA = Stylet::Vector.sincos(Stylet::Fee.degree(180 + 90)) # 速度

    # B
    @pB = @win.srect.half_pos.clone                     # 点
    @rB = Stylet::Rect.new(-30, -50, 30*2, 50*2)        # 大きさ
    @sB = Stylet::Vector.sincos(Stylet::Fee.degree(45)) # 速度

    @speed = 100    # 速度ベクトル 1.0 を画面上では何ドットで表わすか？
    @max_length = 1 # どれだけめり込んだら当たったとみなすか？
  end

  def update
    # 操作
    begin
      # AとBで速度ベクトルの反映
      @pA += @sA.scale(@win.button.btA.repeat_0or1) + @sA.scale(-@win.button.btB.repeat_0or1)
      @pB += @sB.scale(@win.button.btA.repeat_0or1) + @sB.scale(-@win.button.btB.repeat_0or1)

      # Cボタンおしっぱなし + マウスで自機位置移動
      if @win.button.btC.press?
        @pA = @win.cursor.clone
      end

      # Dボタンおしっぱなし + マウスで自機角度変更
      if @win.button.btD.press?
        if @win.cursor != @pA
          @sA = (@win.cursor - @pA).normalize * @sA.radius
        end
      end
    end

    # それぞれを実座標に変換
    @tA = @rA.add_vector(@pA)
    @tB = @rB.add_vector(@pB)

    # めりこみサイズを4辺について調べる
    _l = @tA.max_xi - @tB.min_xi # A|B
    _r = @tB.max_xi - @tA.min_xi # B|A
    _u = @tA.max_yi - @tB.min_yi # A/B
    _d = @tB.max_yi - @tA.min_yi # B/A

    # 当たり判定
    @collision = false
    if true &&
        _l >= @max_length && # A|B
        _r >= @max_length && # B|A
        _u >= @max_length && # A/B
        _d >= @max_length && # B/A
        true

      # @win.__fill_rect2(@tA)

      faces = {_l => :l, _r => :r, _u => :u, _d => :d}
      @win.vputs faces.sort.inspect

      face = faces.sort.first.last
      diff = case face
             when :r; Stylet::Vector.new(_r + 1, 0)
             when :d; Stylet::Vector.new(0, _d + 1)
             when :u; Stylet::Vector.new(0, -(_u + 1))
             when :l; Stylet::Vector.new(-(_l + 1), 0)
             end

      @collision = true
      @pA += diff

      # これも一旦ずらして、反射を入れる

      # 両方はねかえる
      # @pA += diff / 2
      # @pB -= diff / 2

      # @tA = @tA.add_vector(diff.scale(0.99))
      # @pB -= diff.scale(0.01)

      # # 実座標から大きさベクトルを引くと中心点になる
      # @pA = @tA.to_vector - @rA.to_vector

      @tA = @rA.add_vector(@pA)
      @tB = @rB.add_vector(@pB)
    end

    # @win.screen.fill_rect(10, 10, 0, 0, [255, 255, 255])
    # @win.draw_rect2(@tA, :fill => @collision)

    @win.draw_rect2(@tA, :fill => @collision)

    if @win.button.btC.press? && @collision
      # ゴーストの表示
      @win.draw_rect2(@rA.add_vector(@win.cursor))
    end

    @win.vputs "A", :vector => @pA
    @win.vputs "A: #{@tA.to_a.inspect}"
    @win.draw_vector(@sA.scale(@speed), :origin => @pA, :label => @sA.length)

    @win.draw_rect2(@rB.add_vector(@pB))
    @win.vputs "B", :vector => @pB
    @win.vputs "B: #{@rB.to_a.inspect}"
    @win.draw_vector(@sB.scale(@speed), :origin => @pB, :label => @sB.length)
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :reflect_mode

  def before_main_loop
    super if defined? super

    @ray_mode = true           # true:ドット false:円
    @modes = ["reflect", "move", "none"]
    @reflect_mode = @modes.first

    @objects << Scene.new(self)
    @cursor_vertex = 3
  end

  def update
    super if defined? super

    if key_down?(SDL::Key::S)
      @reflect_mode = @modes[@modes.index(@reflect_mode).next.modulo(@modes.size)]
    end

    # 操作説明
    vputs "S:reflect=#{@reflect_mode}"
    vputs "Z:++ X:-- C:drag V:angle"
  end
end

App.main_loop
