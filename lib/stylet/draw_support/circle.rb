# -*- coding: utf-8 -*-
#
# 円・三角形・四角形の描画(向きの指定可)
#
module Stylet
  module DrawSupport
    # 多角形の描画
    #   四角形
    #     win.draw_circle(win.rect.center, :vertex => 4)
    #   三角形で頂点の向きは時計の6時で半径256ピクセル
    #     win.draw_circle(win.rect.center, :vertex => 3, :angle => Fee.r90, :radius => 256)
    def draw_circle(p0, options = {})
      options = {
        :radius => 64,       # 半径
        :vertex => 8,        # n角形
        :angle  => Fee.r270, # 開始地点(初期値は時計の12時)
      }.merge(options)

      raise "options[:vertex] is not Integer" unless options[:vertex].kind_of? Integer
      raise "options[:vertex] >= 1" if options[:vertex].to_i.zero?
      raise "zero vector" if options[:vertex].zero?

      points = options[:vertex].times.collect{|i|
        a = options[:angle] + 1.0 * i / options[:vertex]
        p0 + Vector.angle_at(a) * options[:radius]
      }
      draw_polygon(points, options)
    end

    # 三角形版
    def draw_triangle(p0, options = {})
      draw_circle(p0, {:vertex => 3}.merge(options))
    end

    # 四角形版
    def draw_square(p0, options = {})
      draw_circle(p0, {:vertex => 4}.merge(options))
    end
  end

  if $0 == __FILE__
    require_relative "../../stylet"
    Base.main_loop do |win|
      win.draw_circle(win.rect.center)
      win.draw_triangle(win.rect.center)
      win.draw_square(win.rect.center)
    end
  end
end
