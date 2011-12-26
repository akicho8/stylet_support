require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))
require File.expand_path(File.join(File.dirname(__FILE__), "gunship"))

module BulletTrigger
  def update
    super
    dir = Stylet::Fee.rdirf(@pos.x, @pos.y, @target.pos.x, @target.pos.y)
    if @button.btA.count.modulo(8) == 1
      @base.objects << Bullet.new(@base, @pos.clone, dir, 4.00)
    end
  end
end

class GunShip1 < GunShip
  include Stylet::Input::StandardKeybord
  include Stylet::Input::JoystickBinding
  include BulletTrigger

  def initialize(*)
    super
    @joystick_index = 0
  end
end

class GunShip2 < GunShip
  include Stylet::Input::ViLikeKeyboard
  include Stylet::Input::JoystickBinding
  include BulletTrigger

  def initialize(*)
    super
    @joystick_index = 1
  end
end

class Bullet
  def initialize(base, pos, dir, speed)
    @base = base
    @pos = pos
    @dir = dir
    @speed = speed

    @size = 4
    @radius = 0
  end

  def screen_out?
    unless (@base.min_x - @size .. (@base.max_x + @size)).include?(@pos.x)
      return true
    end
    unless (@base.min_y - @size .. (@base.max_y + @size)).include?(@pos.y)
      return true
    end
    if @radius < 0
      return true
    end
    false
  end

  def update
    @radius += @speed
    x = @pos.x + Stylet::Fee.rcosf(@dir) * @radius
    y = @pos.y + Stylet::Fee.rsinf(@dir) * @radius
    @base.fill_rect(x - @size, y - @size, @size * 2, @size * 2, "white")
  end
end

class App < Stylet::Base
  attr_reader :objects

  def before_main_loop
    super
    @objects = []
    ship1 = GunShip1.new(self, Stylet::Point.new(half_x, half_y - half_y * 0.8))
    ship2 = GunShip2.new(self, Stylet::Point.new(half_x, half_y + half_y * 0.8))
    ship1.target = ship2
    ship2.target = ship1
    @objects << ship1
    @objects << ship2
  end

  def update
    super
    @objects.each{|e|e.update}
  end
end

App.main_loop
