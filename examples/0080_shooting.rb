require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))
require File.expand_path(File.join(File.dirname(__FILE__), "gunship"))

module BulletTrigger
  def update
    super
    dir = Stylet::Fee.angle(@pos.x, @pos.y, @target.pos.x, @target.pos.y)
    if @button.btA.count.modulo(8) == 1
      @win.objects << Bullet.new(@win, @pos.clone, dir, 4.00)
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
  def initialize(win, pos, dir, speed)
    @win = win
    @pos = pos
    @dir = dir
    @speed = speed

    @size = 4
    @radius = 0
  end

  def screen_out?
    unless (@win.rect.min_x - @size .. (@win.rect.max_x + @size)).include?(@pos.x)
      return true
    end
    unless (@win.rect.min_y - @size .. (@win.rect.max_y + @size)).include?(@pos.y)
      return true
    end
    if @radius < 0
      return true
    end
    false
  end

  def update
    @radius += @speed
    x = @pos.x + Stylet::Fee.cos(@dir) * @radius
    y = @pos.y + Stylet::Fee.sin(@dir) * @radius
    @win.draw_rect(Stylet::Rect.new(x - @size, y - @size, @size * 2, @size * 2), :fill => true)
  end
end

class App < Stylet::Base
  attr_reader :objects

  def before_main_loop
    super
    @objects = []
    ship1 = GunShip1.new(self, Stylet::Vector.new(rect.hx, rect.hy - rect.hy * 0.8))
    ship2 = GunShip2.new(self, Stylet::Vector.new(rect.hx, rect.hy + rect.hy * 0.8))
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

