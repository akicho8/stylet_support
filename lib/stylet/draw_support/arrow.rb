# -*- coding: utf-8 -*-
module Stylet
  module DrawSupport
    #
    # ベクトル確認用
    #
    #   開始地点のデフォルトは画面中央になる
    #   開始地点がわかっている場合は origin を指定すること
    #
    def draw_vector(vec, options = {})
      options = {
        :origin => rect.center, # 原点を画面の真中にしておく
      }.merge(options)

      draw_arrow(options[:origin], options[:origin] + vec, options)

      if options[:label]
        vputs options[:label], :vector => options[:origin] + vec
      end
    end

    #
    # p0 から p1 へ矢印の描画
    #
    def draw_arrow(p0, p1, options = {})
      d = (p0 - p1)
      if d.x.nan? || d.y.nan?
        return
      end
      # return if (p0 - p1).length.zero?
      # return if p0 == p1

      options = {
        :angle => Stylet::Fee.r45,               # 傘の開き
        :arrow_size => p0.distance_to(p1) * 0.1, # 傘の大きさは線分の長さに比例
      }.merge(options)

      # 線分の表示
      draw_line(p0, p1, options)

      # 傘の表示
      a = p1.angle_to(p0)
      draw_line(p1, p1 + Vector.angle_at(a + options[:angle]).scale(options[:arrow_size]), options)
      draw_line(p1, p1 + Vector.angle_at(a - options[:angle]).scale(options[:arrow_size]), options)
    # rescue Errno::EDOM
    #   # sqrt のエラーなんででる？
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../../stylet"))
  Stylet::Base.main_loop do |win|
    win.draw_arrow(win.rect.center, win.rect.center + Stylet::Vector.new(50, 50))
    win.draw_vector(Stylet::Vector.new(100, -100), :origin => win.rect.center)
  end
end
