# -*- coding: utf-8 -*-

module Stylet
  module CollisionSupport
    extend self

    #
    #  +--- -r ---+
    #  |     |    |
    # -r -- p0 -- r のなかに p1 の点が含まれているか？
    #  |     |    |
    #  +---- r ---+
    #
    def squire_collision?(p0, p1, options = {})
      options = {
      }.merge(options)
      raise "options[:radius] required" unless options[:radius]
      true &&
        ((p0.x - options[:radius])..(p0.x + options[:radius])).include?(p1.x) &&
        ((p0.y - options[:radius])..(p0.y + options[:radius])).include?(p1.y) &&
        true
    end

    #
    # 領域rectの中に点pが含まれているか？
    #
    def rect_in?(rect, p, options = {})
      true &&
        (rect.min_x <= p.x && p.x <= rect.max_x) &&
        (rect.min_y <= p.y && p.y <= rect.max_y) &&
        true
    end

    #
    # 領域rectの中に点pが含まていない？
    #
    def rect_out?(rect, p, options = {})
      !rect_in?(rect, p, options)
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
