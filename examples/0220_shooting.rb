# -*- coding: utf-8 -*-
require "./setup"

class GunShip
  include Stylet::Input::Base

  attr_reader :pos
  attr_accessor :target

  def initialize(win, pos)
    super()
    @win = win
    @pos = pos                  # 自機の位置
    @speed = 3                  # 移動速度
    @size = 8 * 3               # 自機の大きさ
    @joystick_index = nil       # 自分のジョイスティックの番号
    @target = nil               # 相手
  end

  def update
    super if defined? super

    if @joystick_index
      if joy = @win.joys[@joystick_index]
        update_by_joy(joy)
      end
    end

    key_counter_update_all

    if dir = axis_angle
      next_pos = @pos + Stylet::Vector.angle_at(dir) * @speed
      if Stylet::CollisionSupport.rect_in?(@win.rect, next_pos)
        @pos = next_pos
      end
    end

    @win.draw_triangle(@pos, :radius => @size, :angle => @pos.angle_to(@target.pos))
  end
end

module BulletTrigger
  def update
    super
    if @button.btA.count.modulo(8) == 1
      @win.objects << Bullet.new(@win, @pos.clone, @pos.angle_to(@target.pos), 4.00)
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

    @size = 8
    @radius = 0
  end

  def screen_out?
    Stylet::CollisionSupport.rect_out?(@win.rect, @pos) || @radius < 0
  end

  def update
    @radius += @speed
    @win.draw_triangle(@pos + Stylet::Vector.angle_at(@dir) * @radius, :radius => @size, :angle => @dir)
  end
end

class App < Stylet::Base
  attr_reader :objects

  def before_run
    super
    self.title = "二人対戦シューティング(自己申告制)"
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

App.run
