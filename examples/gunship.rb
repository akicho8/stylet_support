class GunShip
  include Stylet::Input::Base

  attr_reader :pos
  attr_accessor :target

  def initialize(base, pos)
    super()
    @base = base
    @pos = pos
    @speed = 3
    @target = nil
    @size = 8
    @joystick_index = nil
  end

  def update
    super if defined? super

    if @joystick_index
      if joy = @base.joys[@joystick_index]
        update_by_joy(joy)
      end
    end

    key_counter_update_all

    if dir = axis_angle
      x = @pos.x + Stylet::Fee.cos(dir) * @speed
      y = @pos.y + Stylet::Fee.sin(dir) * @speed
      if (@base.min_x..@base.max_x).include?(x)
        @pos.x = x
      end
      if (@base.min_y..@base.max_y).include?(y)
        @pos.y = y
      end
    end

    @base.fill_rect(@pos.x - @size, @pos.y - @size, @size * 2, @size * 2, "white")
  end
end
