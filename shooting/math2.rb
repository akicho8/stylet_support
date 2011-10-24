require "singleton"

AtanAreaInfo = Struct.new(:basedir, :sign)

module SinTableModule
  def initialize
    super
    @sin_table = (0...@around).collect{|i|Math.sin(2 * Math::PI * i / @around)}
  end

  def rsin(r)
    @sin_table[r.modulo(@sin_table.size)]
  end

  def rcos(r)
    rsin(r + @sin_table.size / 4)
  end

  def rsinf(r)
    r = r % 1.0
    @sin_table[(r * @sin_table.size).modulo(@sin_table.size)]
  end

  def rcosf(r)
    rsinf(r + 1.0 / 4)
  end
end

module AtanTableModule
  def initialize
    super
    part = @around / 8
    @atan_table = (0...part).collect{|i|Math.atan2(i, part) * part / (2 * Math::PI / 8)}
    @atan_area_info_table = [
      AtanAreaInfo.new(@around / 4 * 3 + @dir_offset, +1),
      AtanAreaInfo.new(@around / 4 * 0 + @dir_offset, -1),
      AtanAreaInfo.new(@around / 4 * 1 + @dir_offset, -1),
      AtanAreaInfo.new(@around / 4 * 0 + @dir_offset, +1),
      AtanAreaInfo.new(@around / 4 * 3 + @dir_offset, -1),
      AtanAreaInfo.new(@around / 4 * 2 + @dir_offset, +1),
      AtanAreaInfo.new(@around / 4 * 1 + @dir_offset, +1),
      AtanAreaInfo.new(@around / 4 * 2 + @dir_offset, -1),
    ]
  end

  def rdirf(ox, oy, tx, ty)
    rdir(ox, oy, tx, ty) / @around.to_f
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
        index = value * @around / 8 / div_value
        raise unless index < @around / 8
        dirsub = ip.sign * @atan_table[index]
        dir += dirsub
      else
        dir += ip.sign * @around / 8
      end
    end
    dir.modulo(@around)
  end
end

module Math2Initialize
  def initialize
    @around = 4096
    @dir_offset = 0
  end
end

class Math2
  include Singleton
  include Math2Initialize
  include SinTableModule
  include AtanTableModule

  attr_reader :around

  class << self
    [:rdir, :rsin, :rcos, :rdirf, :rsinf, :rcosf, :around].each{|method|
      define_method(method){|*args, &block|
        instance.send(method, *args, &block)
      }
    }
  end
end

if __FILE__ == $PROGRAM_NAME
  p Math2.rsin(0)
  p Math2.rcos(0)
  p Math2.rdir(0, 0, 0, 1)
  p Math2.rsinf(0)
  p Math2.rcosf(0)
end
