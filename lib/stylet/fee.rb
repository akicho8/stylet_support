# -*- coding: utf-8 -*-
require "singleton"

module Stylet
  AtanAreaInfo = Struct.new(:basedir, :sign)
  ONE = 4096       # sin cos の精度
  ROUND = 4096*2   # 4096の場合、64分割以上のときにズレが生じる。8092なら256分割でズレるようだ

  module SinTableModule
    def initialize
      super
      @sin_table = (0...ROUND).collect{|i|(Math.sin(2 * Math::PI * i / ROUND) * ONE).round}
    end

    def isin(a)
      @sin_table[a.modulo(@sin_table.size)]
    end

    def icos(a)
      isin(a + @sin_table.size / 4)
    end

    def sin(a)
      a %= 1.0 # ruby の場合、一周せずに a * @sin_table.size で無限に桁がでかくなる、のを防ぐため
      @sin_table[(a * @sin_table.size).modulo(@sin_table.size)] * 1.0 / ONE
    end

    def cos(a)
      sin(a + 1.0 / 4)
    end
  end

  module AtanTableModule
    def initialize
      super
      part = ROUND / 8
      @atan_table = (0..part).collect{|i|
        (Math.atan2(i, part) * part / (2 * Math::PI / 8)).round
      }
      # p @atan_table # [0, 319, 605, 839]
      @atan_area_info_table = [
        # AtanAreaInfo.new(ROUND * 3 / 4 + @dir_offset, +1),
        # AtanAreaInfo.new(ROUND * 4 / 4 + @dir_offset, -1),
        # AtanAreaInfo.new(ROUND * 1 / 4 + @dir_offset, -1),
        # AtanAreaInfo.new(ROUND * 0 / 4 + @dir_offset, +1),
        # AtanAreaInfo.new(ROUND * 3 / 4 + @dir_offset, -1),
        # AtanAreaInfo.new(ROUND * 2 / 4 + @dir_offset, +1),
        # AtanAreaInfo.new(ROUND * 1 / 4 + @dir_offset, +1),
        # AtanAreaInfo.new(ROUND * 2 / 4 + @dir_offset, -1),

        # AtanAreaInfo.new(ROUND / 8 * 6 + @dir_offset, +1),
        # AtanAreaInfo.new(ROUND / 8 * 7 + @dir_offset, -1),
        # AtanAreaInfo.new(ROUND / 8 * 1 + @dir_offset, -1),
        # AtanAreaInfo.new(ROUND / 8 * 0 + @dir_offset, +1),
        # AtanAreaInfo.new(ROUND / 8 * 5 + @dir_offset, -1),
        # AtanAreaInfo.new(ROUND / 8 * 4 + @dir_offset, +1),
        # AtanAreaInfo.new(ROUND / 8 * 2 + @dir_offset, +1),
        # AtanAreaInfo.new(ROUND / 8 * 3 + @dir_offset, -1),

        AtanAreaInfo.new(ROUND / 4 * 3 + @dir_offset, +1),
        AtanAreaInfo.new(ROUND / 4 * 4 + @dir_offset, -1),
        AtanAreaInfo.new(ROUND / 4 * 1 + @dir_offset, -1),
        AtanAreaInfo.new(ROUND / 4 * 0 + @dir_offset, +1),
        AtanAreaInfo.new(ROUND / 4 * 3 + @dir_offset, -1),
        AtanAreaInfo.new(ROUND / 4 * 2 + @dir_offset, +1),
        AtanAreaInfo.new(ROUND / 4 * 1 + @dir_offset, +1),
        AtanAreaInfo.new(ROUND / 4 * 2 + @dir_offset, -1),
      ]
    end

    def angle(ox, oy, tx, ty)
      iangle(ox, oy, tx, ty).to_f / ROUND
      # v % 1.0 # 一周したとき 1.0 にならないようにするため
    end

    #    4 0
    #  5     1
    #  7     3
    #    6 2
    def iangle(ox, oy, tx, ty)
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
            # p [sx, sy]
            # p [dx, dy]
            if dx < dy
              # p :koko
              dir = local_dir(dx, dy, 0)
            else
              dir = local_dir(dy, dx, 1)
              # p dir
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
      # dir.modulo(ROUND)
      dir
    end

    def local_dir(value, div_value, area_no)
      # p [value, div_value, area_no]
      raise unless value <= div_value
      ip = @atan_area_info_table[area_no]
      dir = ip.basedir
      if div_value.nonzero?
        # p [value, div_value]
        if value != div_value
          # p "#{value} * #{ROUND} / 8 / #{div_value}"
          index = (value.to_f * ROUND / 8 / div_value).round
          raise unless index < @atan_table.size
          # p @atan_table
          # p [dir, index, ip.sign, @atan_table[index]]

          # p({:value => value, :div_value => div_value, :index => index, :dir => dir, :atan_table => @atan_table, :sign => ip.sign})

          dirsub = ip.sign * @atan_table[index]
          # dirsub = dirsub
          dir += dirsub
        else
          dir += ip.sign * ROUND / 8
        end
      end
      # dir.modulo(ROUND) の場合は、振り子の左右の移動量が均等にならない
      # dir.round.modulo(ROUND)
      dir.modulo(ROUND)
    end
  end

  module Initialize
    def initialize
      @dir_offset = 0
    end
  end

  class Fee
    include Singleton
    include Initialize
    include SinTableModule
    include AtanTableModule

    class << self
      [:isin, :icos, :iangle, :sin, :cos, :angle].each{|method|
        define_method(method){|*args, &block|
          instance.send(method, *args, &block)
        }
      }
    end

    def self.one
      ONE
    end

    def self.one_round
      ROUND
    end

    # 一周をアナログ時計の単位と考えたときの角度(抽象化のため)
    def self.clock(hour = 6, minute = 0)
      t = -(1.0 / 4) + (1.0 * (hour % 12) / 12)
      t += 1.0 * minute / (60 * 12)
      t.modulo(1.0) / 1.0.to_f
    end

    # 一周を360度と考えたときの角度(抽象化のため)
    def self.r0; 0; end
    def self.r45; 1.0 / 8.0; end
    def self.r90; 1.0 / 4.0; end
    def self.r180; 1.0 / 2.0; end
    def self.r270; r90 * 3; end

    def self.degree(r)
      r / 360.0
    end

    # 円の右側か？
    def self.cright?(v)
      !cleft?(v)
    end

    # 円の左側か？
    def self.cleft?(v)
      (r90...r270).include?(v % 1.0)
    end
  end
end

if $0 == __FILE__
  require "pp"
  # p Stylet::Fee.cos(0)
  # exit

  # p Stylet::Fee.isin(0)
  # p Stylet::Fee.icos(0)
  # p Stylet::Fee.iangle(0, 0, 0, 1)
  # p Stylet::Fee.sin(0)
  # p Stylet::Fee.cos(0)
  # p Stylet::Fee.iangle(320.0, 240.0, 447.990361835411, 240.429243)

  # n = Stylet::ROUND
  # pp (0..(n*2)).collect{|i|
  #   if i == 4 || true
  #     # r = (Stylet::Fee.one_round / n * i) % Stylet::Fee.one_round
  #     r = (Stylet::Fee.one_round / n * i)
  #     x = Stylet::Fee.icos(r)
  #     y = Stylet::Fee.isin(r)
  #     dir = Stylet::Fee.iangle(0, 0, x, y)
  #     [i, [x, y], r, dir, (r == dir)]
  #   end
  # }.compact

  # n = 32
  # (0..n).collect{|i|
  #   if true
  #     r = ((Stylet::Fee.one_round.to_f * i / n) % Stylet::Fee.one_round)
  #     x = Stylet::Fee.icos(r)
  #     y = Stylet::Fee.isin(r)
  #     dir = Stylet::Fee.iangle(0, 0, x, y)
  #     p [x, y, r, dir, (r == dir)]
  #     r == dir
  #   end
  # }

  # pp (0..8).collect{|i|
  #   r = 1.0 / 8 * i % 1.0
  #   x = Stylet::Fee.cos(r)
  #   y = Stylet::Fee.sin(r)
  #   dir = Stylet::Fee.angle(0, 0, x, y)
  #   [i, r, dir, (r == dir)]
  # }
  # pp (0...8).collect{|i|[i, Stylet::Fee.sin(1.0 / 8 * i)]}
  # pp (0..12).collect{|i|[i, Stylet::Fee.clock(i)]}
end
