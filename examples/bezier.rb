# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

class Bezier < Stylet::Base
  include Stylet::Input::Base
  include Stylet::Input::StandardKeybord
  include Stylet::Input::MouseButtonAsCounter

  attr_accessor :dragging_current

  class MovablePoint < Stylet::Vector
    def initialize(base, *args)
      super(*args)
      @base = base
      @dragging = false # ドラッグ中か？
      @radius = 16      # 当り判定の大きさ
    end

    def update
      unless @dragging
        if @base.button.btA.trigger?
          if Stylet::CollisionSupport.squire_collision?(self, @base.mpos)
            # 他の奴がアクティブじゃなかったときだけ自分を有効にできる
            # これを入れないと同時に複数のポイントをドラッグできてしまう
            unless @base.dragging_current
              @dragging = true
              @base.dragging_current = self
            end
          end
        end
      else
        unless @base.button.btA.press?
          @dragging = false
          @base.dragging_current = nil
        end
      end

      if self == @base.dragging_current
        self.x = @base.mpos.x
        self.y = @base.mpos.y
        @base.draw_circle(self, :radius => @radius, :vertex => 32)
      else
        @base.draw_circle(self, :radius => 2)
      end
    end
  end

  def before_main_loop
    super if defined? super

    @points = []            # ポイント配列
    @dragging_current = nil # 現在どのポイントをドラッグしているか？
    @line_count = 256       # 軌跡確認用弧線の構成ライン数初期値(確認用)
  end

  def update
    super if defined? super
    key_counter_update_all

    # ポイント位置のドラッグと描画
    @points.each{|e|e.update}

    if false
      # 構成ライン数の減算
      @line_count += @button.btC.repeat
      @line_count -= @button.btD.repeat
      @line_count = [2, @line_count].max
      vputs "@line_count = #{@line_count}"
    end

    # ドラッグ中またはAボタンを押したときは詳細表示
    if @dragging_current || @button.btA.press?
      # ポイントの番号の表示
      @points.each_with_index{|e, i|vputs(i, :vector => e)}

      # 弧線の描画
      xys = points_all
      @line_count.times{|i|
        p0 = xys[i]
        p1 = xys[i.next]
        draw_line(p0.x, p0.y, p1.x, p1.y)
      }
    end

    unless @points.empty?
      # 物体をいったりきたりさせる
      if false
        # ○の表示
        pos = 0.5 + (Stylet::Fee.sin(1.0 / 128 * @count) * 0.5)
        xy = bezier_point(@points, pos)
        draw_circle(xy, :radius => 16, :vertex => 32)
        vputs(pos)
      else
        # △の表示で進んでいる方向を頂点にする
        pos0 = 0.5 + (Stylet::Fee.sin(1.0 / 128 * @count) * 0.5)      # 現在の位置(0.0〜1.0)
        pos1 = 0.5 + (Stylet::Fee.sin(1.0 / 128 * @count.next) * 0.5) # 未来の位置(0.0〜1.0)
        p0 = bezier_point(@points, pos0)                                 # 現在の座標
        p1 = bezier_point(@points, pos1)                                 # 未来の座標
        dir = Stylet::Fee.angle(p0.x, p0.y, p1.x, p1.y)                 # 現在から未来への向きを取得 FIXME: ruby 1.9 だと綺麗にかける
        draw_circle(p0, :offset => dir, :radius => 64, :vertex => 3)     # 三角の頂点を未来への向きに設定して三角描画
        vputs(pos0)
        vputs(dir)
      end

      if @button.btB.trigger?
        # 最後に制御点の追加
        @points = [@points.first(@points.size - 1), MovablePoint.new(self, rand(width), rand(height)), @points.last].flatten
        update_title
      end
      if @button.btC.trigger?
        # 最後の制御点を削除
        if @points.size >= 2
          @points[-2] = nil
          @points.compact!
          update_title
        end
      end
      vputs "#{@points.size} (B+ C-)"
    end
  end

  def update_title
    self.title = "#{@points.size - 1}次ベジェ曲線"
  end

  def points_all
    (0...@line_count.next).collect{|i|
      bezier_point(@points, 1.0 / @line_count * i)
    }
  end
end

if $0 == __FILE__
  Bezier.main_loop
end
