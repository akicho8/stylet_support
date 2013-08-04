# -*- coding: utf-8 -*-

require_relative "helper"

class MovablePoint
  attr_reader :pos

  def initialize(unit, pos)
    @unit = unit
    @pos = pos.clone

    @win = @unit.win
    @dragging = false # ドラッグ中か？
    @radius = 16      # 当り判定の大きさ
  end

  def update
    # ここはモジュール化できる
    begin
      unless @dragging
        if @win.button.btA.trigger?
          if Stylet::CollisionSupport.squire_collision?(@pos, @win.mouse.point, :radius => 8)
            # 他の奴がアクティブじゃなかったときだけ自分を有効にできる
            # これを入れないと同時に複数のポイントをドラッグできてしまう
            unless @unit.dragging_current
              @dragging = true
              @unit.dragging_current = self
            end
          end
        end
      else
        unless @win.button.btA.press?
          @dragging = false
          @unit.dragging_current = nil
        end
      end

      if self == @unit.dragging_current
        @pos = @win.mouse.point.clone
      end
    end

    if self == @unit.dragging_current
      @win.draw_circle(@pos, :radius => @radius, :vertex => 32)
    else
      @win.draw_circle(@pos, :radius => 2)
    end
  end
end

module BezierUnitBase
  attr_accessor :dragging_current
  attr_accessor :win

  def initialize(win)
    @win = win

    @mpoints = []           # ポイント配列
    @dragging_current = nil # 現在どのポイントをドラッグしているか？
    @line_count = 160       # 軌跡確認用弧線の構成ライン数初期値(確認用)

    setup
    update_title
  end

  def setup
    raise NotImplementedError, "#{__method__} is not implemented"
  end

  def update
    # ポイント位置のドラッグと描画
    @mpoints.each{|e|e.update}

    if false
      # 構成ライン数の減算
      @line_count += @win.button.btC.repeat
      @line_count -= @win.button.btD.repeat
      @line_count = [2, @line_count].max
      @win.vputs "@line_count = #{@line_count}"
    end

    # ドラッグ中またはAボタンを押したときは詳細表示
    if @dragging_current || @win.button.btA.press?
      # 弧線の描画
      xys = mpoints_all
      @line_count.times{|i|
        p0 = xys[i]
        p1 = xys[i.next]
        @win.draw_line(p0, p1)
      }
    end

    # ポイントの番号の表示
    @mpoints.each_with_index{|e, i|@win.vputs(i, :vector => e.pos)}

    unless @mpoints.empty?
      # 物体をいったりきたりさせる
      if true
        # ○の表示
        pos = 0.5 + (Stylet::Fee.sin(@win.count / 256.0) * 0.5)
        xy = __bezier_point(pos)
        @win.draw_circle(xy, :radius => 64, :vertex => 32)
        @win.vputs(pos)
      else
        # △の表示で進んでいる方向を頂点にする
        pos0 = 0.5 + (Stylet::Fee.sin(1.0 / 256 * @win.count) * 0.5)      # 現在の位置(0.0〜1.0)
        pos1 = 0.5 + (Stylet::Fee.sin(1.0 / 256 * @win.count.next) * 0.5) # 未来の位置(0.0〜1.0)
        p0 = __bezier_point(pos0)                                         # 現在の座標
        p1 = __bezier_point(pos1)                                         # 未来の座標
        @win.draw_triangle(p0, :angle => p0.angle_to(p1), :radius => 64)  # 三角の頂点を未来への向きに設定して三角描画
      end

      if @win.button.btB.trigger?
        # 最後に制御点の追加
        @mpoints = [
          @mpoints.first(@mpoints.size - 1),
          MovablePoint.new(self, @mpoints.last.pos + Stylet::Vector.new(-30, 0)),
          @mpoints.last,
        ].flatten
        update_title
      end
      if @win.button.btC.trigger?
        # 最後の制御点を削除
        if @mpoints.size >= 2
          @mpoints[-2] = nil
          @mpoints.compact!
          update_title
        end
      end
      @win.vputs "#{@mpoints.size} (B+ C-)"
    end
  end

  def update_title
    @win.title = "#{@mpoints.size - 1}次ベジェ曲線"
  end

  def mpoints_all
    @line_count.next.times.collect{|i|
      __bezier_point(1.0 / @line_count * i)
    }
  end

  def __bezier_point(*args)
    bezier_point(@mpoints.collect{|e|e.pos}, *args)
  end

  def bezier_point(*args)
    raise NotImplementedError, "#{__method__} is not implemented"
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  def before_main_loop
    super if defined? super
    @objects << BezierUnit.new(self)
  end
end
