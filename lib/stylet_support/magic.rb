require "singleton"

module Stylet
  ONE    = 4096     # sin cos の精度
  AROUND = 4096 * 2 # 4096の場合、64分割以上のときにズレが生じる。8092なら256分割でズレるようだ

  class Magic
    include Singleton

    def initialize
      @dir_offset = 0
    end

    prepend Module.new {
      def initialize
        super
        @sin_table = AROUND.times.collect { |i| (Math.sin(2 * Math::PI * i / AROUND) * ONE).round }
      end

      def _rsin(a)
        @sin_table[a.modulo(@sin_table.size)]
      end

      def _rcos(a)
        _rsin(a + @sin_table.size / 4)
      end

      def rsin(a)
        a = a.modulo(1.0) # ruby の場合、一周せずに a * @sin_table.size で無限に桁がでかくなる、のを防ぐため
        @sin_table[(a * @sin_table.size).modulo(@sin_table.size)] * 1.0 / ONE
      end

      def rcos(a)
        rsin(a + 1.0 / 4)
      end
    }

    prepend Module.new {
      AtanAreaInfo = Struct.new(:base_dir, :sign)

      def initialize
        super
        part = AROUND / 8
        @atan_table = (0..part).collect {|i|
          (Math.atan2(i, part) * part / (2 * Math::PI / 8)).round
        }
        @atan_area_info_table = [
          AtanAreaInfo.new(AROUND / 4 * 3 + @dir_offset, +1),
          AtanAreaInfo.new(AROUND / 4 * 4 + @dir_offset, -1),
          AtanAreaInfo.new(AROUND / 4 * 1 + @dir_offset, -1),
          AtanAreaInfo.new(AROUND / 4 * 0 + @dir_offset, +1),
          AtanAreaInfo.new(AROUND / 4 * 3 + @dir_offset, -1),
          AtanAreaInfo.new(AROUND / 4 * 2 + @dir_offset, +1),
          AtanAreaInfo.new(AROUND / 4 * 1 + @dir_offset, +1),
          AtanAreaInfo.new(AROUND / 4 * 2 + @dir_offset, -1),
        ]
      end

      def angle(ox, oy, tx, ty)
        iangle(ox, oy, tx, ty).to_f / AROUND
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
        # dir.modulo(AROUND)
        dir
      end

      def local_dir(value, div_value, area_no)
        # p [value, div_value, area_no]
        unless value <= div_value
          raise ArgumentError, "#{value} <= #{div_value}"
        end
        ip = @atan_area_info_table[area_no]
        dir = ip.base_dir
        if div_value.nonzero?
          if value != div_value
            index = (value.to_f * AROUND / 8 / div_value).round
            raise unless index < @atan_table.size
            dirsub = ip.sign * @atan_table[index]
            dir += dirsub
          else
            dir += ip.sign * AROUND / 8
          end
        end
        # dir.modulo(AROUND) の場合は、振り子の左右の移動量が均等にならない
        # dir.round.modulo(AROUND)
        dir.modulo(AROUND)
      end
    }

    class << self
      [:_rsin, :_rcos, :iangle, :rsin, :rcos, :angle].each do |method|
        define_method(method) do |*args, &block|
          instance.send(method, *args, &block)
        end
      end

      def one
        ONE
      end

      def one_round
        AROUND
      end

      # 一周をアナログ時計の単位と考えたときの角度(抽象化のため)
      def clock(hour = 6, minute = 0)
        t = -(1.0 / 4) + (1.0 * (hour % 12) / 12)
        t += minute.fdiv(60 * 12)
        t.modulo(1.0) / 1.0
      end

      # 一周を360度と考えたときの角度(抽象化のため)
      def r0;           0; end
      def r45;  1.0 / 8.0; end
      def r90;  1.0 / 4.0; end
      def r180; 1.0 / 2.0; end
      def r270;   r90 * 3; end

      def degree(r)
        r / 360.0
      end

      # 円の右側か？
      def cright?(v)
        !cleft?(v)
      end

      # 円の左側か？
      def cleft?(v)
        (r90...r270).include?(v % 1.0)
      end

      # from から to への差分
      def angle_diff(from: nil, to: nil)
        v = to.modulo(1.0) - from.modulo(1.0)
        if v < -1.0 / 2
          1.0 + v
        elsif v > 1.0 / 2
          -1.0 + v
        else
          v
        end
      end
    end
  end
end

if $0 == __FILE__
  require "pp"
  # p Stylet::Magic.rcos(0)
  # exit

  # p Stylet::Magic._rsin(0)
  # p Stylet::Magic._rcos(0)
  # p Stylet::Magic.iangle(0, 0, 0, 1)
  # p Stylet::Magic.rsin(0)
  # p Stylet::Magic.rcos(0)
  # p Stylet::Magic.iangle(320.0, 240.0, 447.990361835411, 240.429243)

  # n = Stylet::AROUND
  # pp (0..(n*2)).collect{|i|
  #   if i == 4 || true
  #     # r = (Stylet::Magic.one_round / n * i) % Stylet::Magic.one_round
  #     r = (Stylet::Magic.one_round / n * i)
  #     x = Stylet::Magic._rcos(r)
  #     y = Stylet::Magic._rsin(r)
  #     dir = Stylet::Magic.iangle(0, 0, x, y)
  #     [i, [x, y], r, dir, (r == dir)]
  #   end
  # }.compact

  # n = 32
  # (0..n).collect{|i|
  #   if true
  #     r = ((Stylet::Magic.one_round.to_f * i / n) % Stylet::Magic.one_round)
  #     x = Stylet::Magic._rcos(r)
  #     y = Stylet::Magic._rsin(r)
  #     dir = Stylet::Magic.iangle(0, 0, x, y)
  #     p [x, y, r, dir, (r == dir)]
  #     r == dir
  #   end
  # }

  # pp (0..8).collect{|i|
  #   r = 1.0 / 8 * i % 1.0
  #   x = Stylet::Magic.rcos(r)
  #   y = Stylet::Magic.rsin(r)
  #   dir = Stylet::Magic.angle(0, 0, x, y)
  #   [i, r, dir, (r == dir)]
  # }
  # pp 8.times.collect{|i|[i, Stylet::Magic.rsin(1.0 / 8 * i)]}
  # pp (0..12).collect{|i|[i, Stylet::Magic.clock(i)]}
end
