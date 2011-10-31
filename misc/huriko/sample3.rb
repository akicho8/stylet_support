$LOAD_PATH << ".." if $0 == __FILE__

NNN = 15

require "config"
if false
  CONFIG[:full_screen] = true
  # CONFIG[:screen_size] = [1024, 768]
  CONFIG[:screen_size] = [640, 480]
  CONFIG[:joy_debug] = false
else
  CONFIG[:full_screen] = false
  CONFIG[:screen_size] = [512, 384]
end

require "ui/sdl/draw"
require "math2"

UI::Color::Palette.update({"white" => [255, 255, 255]})
UI::Color::Palette.update({"gray"  => [128, 255, 128]})
UI::Color::Palette.update({"font"  => [128, 255, 128]})

class SpaceObject
  def initialize(base)
    @base = base
    @count = 0
  end

  def screen_out?
    false
  end

  def compute
  end

  def draw
    @count += 1
  end
end

class Ball < SpaceObject
  attr_accessor :cx, :cy, :radius, :speed, :dir, :index

  def initialize(base)
    super(base)
    @count = 0
    @haba = 1.0 / 8
  end

  def compute
    super
    @dir = 1.0 / 4 + Math2.rsinf(@count * (1.0 / 4096 * (@radius / 8.0))) * (1.0 / 8)
    # @dir = 1.0 / 4 + Math2.rsinf(@count * (1.0 / 4096 * (@radius / 4.0 * 32.0)) * @haba
    # @haba -= ((150 - @radius) * 2 * 0.000001)
    # @haba -= ((NNN - @index) * 32 * 0.000001)
    # if @haba < 0
    #   @haba = 0
    # end
  end

  def draw
    super

    @x = @cx + Math2.rcosf(@dir) * @radius
    @y = @cy + Math2.rsinf(@dir) * @radius

    _radius = 10

    n = 16
    points = (0...n).collect{|i|
      dir = (1.0 / n) * i
      [
        @x + Math2.rcosf(dir) * _radius,
        @y + Math2.rsinf(dir) * _radius,
      ]
    }
    points.size.times{|i|
      x1, y1 = points[i % points.size]
      x2, y2 = points[i.next % points.size]
      UI::Sdl::Draw.instance.draw_line(x1, y1, x2, y2, "gray")
      # UI::Sdl::Draw.instance.draw_rect(x1, y1, x2, y2, "gray")
    }
    UI::Sdl::Draw.instance.draw_line(@cx, @cy, @x, @y, "gray")

    # UI::Sdl::Draw.instance.fill_rect(@x - size, @y - size, size * 2, size * 2, "white")
  end
end

class SilentSpace
  def initialize
  end

  def draw_start
  end

  def draw_main
  end

  def draw_end
  end

  def system_infos
    [@draw_inst.system_line]
  end

  def run
    @draw_inst = UI::Sdl::Draw.instance
    catch(:exit){
      loop do
        @draw_inst.polling
        @draw_inst.draw_begin
        @draw_inst.bg_clear
        @draw_inst.count += 1
        @draw_inst.gprint(0, 0, system_infos.compact.join(" "))
        draw_start
        draw_main
        draw_end
        @draw_inst.draw_end
      end
    }
    @draw_inst.close
  end
end

class WarSpace < SilentSpace
  attr_reader :balls

  def initialize
    super
    @count = 0
    @balls = []
  end

  def system_infos
    super
  end

  def draw_end
    super

    @balls.each{|object|object.compute}
    @balls.each{|object|object.draw}

    @count += 1
  end
end

class Application < WarSpace
  def initialize
    super
    @draw_inst = UI::Sdl::Draw.instance
    NNN.times{|i|
      @balls << Ball.new(self).tap{|ball|
        ball.cx = @draw_inst.width / 2
        ball.cy = @draw_inst.height / 8 * 1
        ball.radius = 100 + i * 10
        ball.dir = 1.0 / 4 + (i * 1.0 / 64)
        ball.index = i
      }
    }
  end
end

Application.new.run
