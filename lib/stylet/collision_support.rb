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
  end
end
