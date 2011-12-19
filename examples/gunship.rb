class GunShip
  include Stylet::Input::Base

  attr_reader :x, :y
  attr_accessor :target

  def initialize(base, x, y, *)
    super()
    @base = base
    @x = x
    @y = y
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

    if dir = directionf
      tx = @x + Stylet::Fee.rcosf(dir) * @speed
      ty = @y + Stylet::Fee.rsinf(dir) * @speed
      if (@base.min_x..@base.max_x).include?(tx)
        @x = tx
      end
      if (@base.min_y..@base.max_y).include?(ty)
        @y = ty
      end
    end

    @base.fill_rect(@x - @size, @y - @size, @size * 2, @size * 2, "white")
  end
end
