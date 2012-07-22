# -*- coding: utf-8 -*-
require_relative "vector"

module Stylet
  class Rect < Vector
    attr_accessor :wh

    def self.create(*args)
      new(*args)
    end

    def self.centered_create(rx, ry = rx)
      new(-rx, -ry, rx * 2, ry * 2)
    end

    def initialize(x, y, w, h)
      super(x, y)
      @wh = Vector.new(w, h)
    end

    def w
      @wh.x
    end

    def h
      @wh.y
    end

    #--------------------------------------------------------------------------------
    def min_x
      x
    end

    def max_x
      x + w - 1
    end

    def min_y
      y
    end

    def max_y
      y + h - 1
    end

    #--------------------------------------------------------------------------------
    # 描画と合わせるため小数点があると当たり判定が一致しなくなる
    def min_xi
      min_x.to_i
    end

    def max_xi
      max_x.to_i
    end

    def min_yi
      min_y.to_i
    end

    def max_yi
      max_y.to_i
    end

    #--------------------------------------------------------------------------------
    def hx
      x + w / 2
    end

    def hy
      y + h / 2
    end

    alias width w
    alias height h

    def center
      Vector.new(hx, hy)
    end

    def add_vector(vec)
      self.class.new(x + vec.x, y + vec.y, w, h)
    end

    def sub_vector(vec)
      self.class.new(x - vec.x, y - vec.y, w, h)
    end

    def to_vector
      Vector.new(x, y)
    end

    def rect_vector
      Vector.new(w - 1, y - 1)
    end

    def inspect
      "#{super} #{@wh.inspect}"
    end

    def to_a
      [super.to_a, @wh.to_a].flatten
    end
  end
end

if $0 == __FILE__
  p Stylet::Rect.new(2, 3, 4, 5)
  p Stylet::Rect.new(2, 3, 4, 5).add_vector(Stylet::Vector.new(6, 7))
end
