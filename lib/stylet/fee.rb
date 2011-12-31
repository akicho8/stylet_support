# -*- coding: utf-8 -*-
require "singleton"

module Stylet
  AtanAreaInfo = Struct.new(:basedir, :sign)

  module SinTableModule
    def initialize
      super
      @sin_table = (0...@one).collect{|i|Math.sin(2 * Math::PI * i / @one)}
    end

    def rsin(r)
      @sin_table[r.modulo(@sin_table.size)]
    end

    def rcos(r)
      rsin(r + @sin_table.size / 4)
    end

    def rsinf(r)
      r %= 1.0
      @sin_table[(r * @sin_table.size).modulo(@sin_table.size)]
    end

    def rcosf(r)
      rsinf(r + 1.0 / 4)
    end
  end

  module AtanTableModule
    def initialize
      super
      part = @one / 8
      @atan_table = (0...part).collect{|i|Math.atan2(i, part) * part / (2 * Math::PI / 8)}
      @atan_area_info_table = [
        AtanAreaInfo.new(@one * 3 / 4 + @dir_offset, +1),
        AtanAreaInfo.new(@one * 0 / 4 + @dir_offset, -1),
        AtanAreaInfo.new(@one * 1 / 4 + @dir_offset, -1),
        AtanAreaInfo.new(@one * 0 / 4 + @dir_offset, +1),
        AtanAreaInfo.new(@one * 3 / 4 + @dir_offset, -1),
        AtanAreaInfo.new(@one * 2 / 4 + @dir_offset, +1),
        AtanAreaInfo.new(@one * 1 / 4 + @dir_offset, +1),
        AtanAreaInfo.new(@one * 2 / 4 + @dir_offset, -1),
      ]
    end

    # 一周したときに 1.0 にならないようにするにはさらに v %= 1.0 すればよいがいまのところ必要なさそう
    def rdirf(ox, oy, tx, ty)
      v = rdir(ox, oy, tx, ty) / @one.to_f
      v % 1.0
    end

    #    4 0
    #  5     1
    #  7     3
    #    6 2
    def rdir(ox, oy, tx, ty)
      dir = nil

      sx = tx - ox
      sy = ty - oy

      dx = sx
      dy = sy

      dx = dx.abs
      dy = dy.abs
      if sx.zero? && sy.zero?
        dir = 0
      else
        if sx >= 0
          if sy <= 0
            if dx < dy
              dir = local_dir(dx, dy, 0)
            else
              dir = local_dir(dy, dx, 1)
            end
          else
            if dx < dy
              dir = local_dir(dx, dy, 2)
            else
              dir = local_dir(dy, dx, 3)
            end
          end
        else
          if sy <= 0
            if dx < dy
              dir = local_dir(dx, dy, 4)
            else
              dir = local_dir(dy, dx, 5)
            end
          else
            if dx < dy
              dir = local_dir(dx, dy, 6)
            else
              dir = local_dir(dy, dx, 7)
            end
          end
        end
      end
      dir
    end

    def local_dir(value, div_value, area_no)
      raise unless value <= div_value
      ip = @atan_area_info_table[area_no]
      dir = ip.basedir
      if div_value.nonzero?
        if value != div_value
          index = value * @one / 8 / div_value
          raise unless index < @one / 8
          dirsub = ip.sign * @atan_table[index]
          dir += dirsub
        else
          dir += ip.sign * @one / 8
        end
      end
      # dir.modulo(@one) の場合は、振り子の左右の移動量が均等にならない
      dir.round.modulo(@one)
    end
  end

  module Initialize
    def initialize
      @one = 4096 * 4
      @dir_offset = 0
    end
  end

  class Fee
    include Singleton
    include Initialize
    include SinTableModule
    include AtanTableModule

    attr_reader :one

    class << self
      [:rdir, :rsin, :rcos, :rdirf, :rsinf, :rcosf, :one].each{|method|
        define_method(method){|*args, &block|
          instance.send(method, *args, &block)
        }
      }
    end

    def self.clock(hour = 6, minute = 0)
      t = -(1.0 / 4) + (1.0 * (hour % 12) / 12)
      t += 1.0 * minute / (60 * 12)
      t.modulo(1.0) / 1.0.to_f
    end

    def self.r0
      0
    end

    def self.r45
      1.0 / 8.0
    end

    def self.r90
      1.0 / 4.0
    end

    def self.r180
      1.0 / 2.0
    end

    def self.rRight?(v)
      !rLeft?(v)
    end

    def self.rLeft?(v)
      (r90 ... (r90 + r180)).include?(v % 1.0)
    end
  end
end

if $0 == __FILE__
  # p Stylet::Fee.rsin(0)
  # p Stylet::Fee.rcos(0)
  # p Stylet::Fee.rdir(0, 0, 0, 1)
  # p Stylet::Fee.rsinf(0)
  # p Stylet::Fee.rcosf(0)
  # p Stylet::Fee.rdir(320.0, 240.0, 447.990361835411, 240.429243)
  (0..12).each{|i|
    p [i, Stylet::Fee.clock(i)]
  }
end
