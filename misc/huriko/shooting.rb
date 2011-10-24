#!/opt/local/bin/rsdl -Ku

$LOAD_PATH << ".." if $0 == __FILE__

require "config"
if true
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

class GunShip1 < SpaceObject
  attr_reader :x, :y
  attr_accessor :target
  def initialize(base, x, y)
    super(base)
    @x = x
    @y = y
    @joy_index = 0
    @speed = 3
    @target = nil
  end

  def joy
    UI::Sdl::JoyStickUtils.instance.joys[@joy_index]
  end

  def compute
    super
    if joy
      if dir = joy.direction
        tx = @x + Math2.rcosf(dir) * @speed
        ty = @y + Math2.rsinf(dir) * @speed
        if (0...UI::Sdl::Draw.instance.width).include?(tx)
          @x = tx
        end
        if (0...UI::Sdl::Draw.instance.height).include?(ty)
          @y = ty
        end
      end
    end
  end

  def draw
    super
    size = 8
    UI::Sdl::Draw.instance.fill_rect(@x - size, @y - size, size * 2, size * 2, "white")

    if @base.visual_mode
      w = UI::Sdl::Draw.instance.width
      h = UI::Sdl::Draw.instance.height
      UI::Sdl::Draw.instance.draw_line(@x, @y, 0,     @y, "gray")
      UI::Sdl::Draw.instance.draw_line(@x, @y, w - 1, @y, "gray")
      UI::Sdl::Draw.instance.draw_line(@x, @y, @x, 0,     "gray")
      UI::Sdl::Draw.instance.draw_line(@x, @y, @x, h - 1, "gray")
    end
  end
end

class GunShip2 < GunShip1
  def initialize(*)
    super
    @joy_index = 1
  end
end

class SilentSpace
  attr_reader :visual_mode, :pause_mode, :ms_x, :ms_y

  def initialize
    @pause_mode = false
    @visual_mode = false
  end

  def __one_button
    if sdl_event = UI::Sdl::Draw.instance.sdl_event
      if sdl_event.kind_of? SDL::Event::KeyDown
        sdl_event.sym
      end
    end
  end

  def one_button?(value)
    __one_button == value
  end

  def press_button?(value)
    SDL::Key.press?(value)
  end

  def draw_start
    SDL::Key.scan
    @ms_x, @ms_y, @lbutton, @cbutton, @rbutton = SDL::Mouse.state
    if one_button?(SDL::Key::SPACE)
      @pause_mode = !@pause_mode
    end
    if one_button?(SDL::Key::RETURN)
      @visual_mode = !@visual_mode
    end
  end

  def draw_main
  end

  def draw_end
  end

  def system_infos
    [@draw_inst.system_line, (@pause_mode ? "P" : nil)]
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
  attr_reader :ships, :bullets

  def initialize
    super
    @count = 0
    @bullets = []
    @ships = []
  end

  def system_infos
    super + [@bullets.size]
  end

  def draw_end
    super

    @bullets.each{|bullet|bullet.compute}
    @bullets.reject!{|bullet|bullet.screen_out?}
    @bullets.each{|bullet|bullet.draw}

    @ships.each{|object|object.compute}
    @ships.each{|object|object.draw}

    @count += 1
  end
end

module CircleGrid
  def custom_move
    super
  end

  def draw
    super
    if @base.visual_mode
      n = 32
      points = (0...n).collect{|i|
        dir = (1.0 / n) * i
        [
          @cx + Math2.rcosf(dir) * @radius,
          @cy + Math2.rsinf(dir) * @radius,
        ]
      }
      points.size.times{|i|
        x1, y1 = points[i % points.size]
        x2, y2 = points[i.next % points.size]
        UI::Sdl::Draw.instance.draw_line(x1, y1, x2, y2, "gray")
      }
      UI::Sdl::Draw.instance.draw_line(@cx, @cy, @x, @y, "gray")
    end
  end
end

class BulletBase < SpaceObject
  def initialize(base, cx, cy, dir, speed)
    super(base)
    @cx = cx
    @cy = cy
    @dir = dir
    @speed = speed

    @size = 4
    @radius = 0
    @count = 0
  end

  def screen_out?
    unless (0 - @size .. (UI::Sdl::Draw.instance.width  - 1 + @size)).include?(@x)
      return true
    end
    unless (0 - @size .. (UI::Sdl::Draw.instance.height - 1 + @size)).include?(@y)
      return true
    end
    if @radius < 0
      return true
    end
    false
  end

  def compute
    super
    unless @base.pause_mode
      @radius += @speed
    end
    compute_sincos
  end

  def compute_sincos
    @x = @cx + Math2.rcosf(@dir) * @radius
    @y = @cy + Math2.rsinf(@dir) * @radius
  end

  def draw
    UI::Sdl::Draw.instance.fill_rect(@x - @size, @y - @size, @size * 2, @size * 2, "white")
  end
end

class Bullet < BulletBase
  include CircleGrid
end

if __FILE__ == $PROGRAM_NAME
  module ShipleBullet
    def compute
      super
      dir = Math2.rdirf(@x, @y, @target.x, @target.y)
      if (joy && joy.button(0)) || @base.press_button?(SDL::Key::Z)
        if @count.modulo(60 / 6).zero?
          @base.bullets << Bullet.new(@base, @x, @y, dir, 3.00)
        end
      end
    end
  end

  class GunShipA < GunShip1
    include ShipleBullet
  end

  class GunShipB < GunShip2
    include ShipleBullet
  end

  class Application < WarSpace
    def initialize
      super
      @draw_inst = UI::Sdl::Draw.instance
      ship1 = GunShipA.new(self, @draw_inst.width / 2, @draw_inst.height / 8 * 1)
      ship2 = GunShipB.new(self, @draw_inst.width / 2, @draw_inst.height / 8 * 7)
      ship1.target = ship2
      ship2.target = ship1
      @ships << ship1
      @ships << ship2
    end
  end

  Application.new.run
end
