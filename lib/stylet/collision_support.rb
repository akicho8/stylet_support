# -*- coding: utf-8 -*-

module Stylet
  module CollisionSupport
    extend self

    def squire_collision?(p0, p1, options = {})
      options = {
        :r => 8,
      }.merge(options)
      ((p0.x - options[:r])..(p0.x + options[:r])).include?(p1.x) && ((p0.y - options[:r])..(p0.y + options[:r])).include?(p1.y)
    end

    #
    # どこかが接触したか？
    #
    def rect_collision?(rect, p, options = {})
      (rect.min_x <= p.x && p.x <= rect.max_x) && (rect.min_y <= p.y && p.y <= rect.max_y)
    end

    # 長方形aと長方形bの一部が接触しているか？
    def rect_collision2?(a, b)
      # めりこみサイズを4辺について調べる
      _l = a.max_xi - b.min_xi # A|B
      _r = b.max_xi - a.min_xi # B|A
      _u = a.max_yi - b.min_yi # A/B
      _d = b.max_yi - a.min_yi # B/A

      if true &&
          _l >= 1 && # A|B
          _r >= 1 && # B|A
          _u >= 1 && # A/B
          _d >= 1 && # B/A
          true
        true
      end
    end

    # 長方形aのなかにbが含まれているか？
    def rect_include?(a, b)
      if true && 
          a.min_xi <= b.min_xi &&
          b.max_xi <= a.max_xi &&
          a.min_yi <= b.min_yi &&
          b.max_yi <= a.max_yi &&
          true
        true
      end
    end
  end
end
