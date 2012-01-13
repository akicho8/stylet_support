# -*- coding: utf-8 -*-
#
# 紐・幼虫・多関節のアルゴリズム
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Joint
  attr_accessor :p0

  def initialize(win, index, p0)
    @win = win
    @index = index    # 自分の番号
    @p0 = p0          # 間接の位置
  end

  def update
    # 次の位置の間接を取得
    @target = @win.objects[@index.next]

    if @target
      distance = @p0.distance_to(@target.p0)
      gap = distance - @win.length
      if gap > 0
        # 相手の方から自分の方へ移動する
        # そのときの移動量を @win.hard_level で調整する
        # 1.0 なら相手との間隔をすべて埋めることになるので紐になる
        # 0.1 ならゆっくりと自分に近付いてくる
        len = gap * @win.hard_level
        dir = @target.p0.angle_to(@p0)
        @target.p0 += Stylet::Vector.angle_at(dir) * len

        # 固さ 1.0 のときは次のように p0 の方から相手をひっぱる方法でもよいが前者の方が、ゆっくり移動させるなど応用が効く
        # dir = @p0.angle_to(@target.p0)
        # @target.p0 += Stylet::Vector.angle_at(dir) * @win.length
      end
    end

    # 頭だけカーソルで動かす
    if @index.zero?
      @p0 = @win.cursor
    end

    # 次の間接まで線を引く
    if @target
      @win.draw_line(@p0, @target.p0)
    end

    # 胴体の表示
    if @win.body_display
      @win.draw_circle(@p0, :radius => @win.length / 2, :vertex => 16)
    end
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :body_display
  attr_reader :length
  attr_reader :hard_level

  def before_main_loop
    super if defined? super
    @objects = Array.new(42){|i|Joint.new(self, i, rect.center.clone)}
    @cursor_display = false     # 三角カーソル非表示

    @body_display = true # 胴体描画モード
    @length = 32         # 線と線の間
    @hard_level = 1.0    # 幼虫の間接の伸び(堅い1.0〜柔らか0.1)
  end

  def update
    super if defined? super

    # 操作
    begin
      # 間接と間接の距離の調整
      @length += (@button.btA.repeat - @button.btB.repeat)
      @length = Stylet::Etc.range_limited(@length, (1..80))

      # 固さ調整
      @hard_level += (@button.btC.repeat - @button.btD.repeat) * 0.1
      @hard_level = Stylet::Etc.range_limited(@hard_level)

      # 円の表示トグル
      if key_down?(SDL::Key::A)
        @body_display = !@body_display
      end
    end

    # 操作説明
    vputs "A:body_display"
    vputs "Z:len++ X:len-- C:hard_level++ V:hard_level--"
    vputs "length=#{@length}"
    vputs "hard_level=#{@hard_level}"

    # 固さ1.0なら紐モード表示
    if @hard_level == 1.0
      vputs "string mode"
    else
      vputs "worm mode"
    end
  end
end

App.main_loop
