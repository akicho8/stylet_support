class GunShip
  include Stylet::Input::Base

  attr_reader :pos
  attr_accessor :target

  def initialize(win, pos)
    super()
    @win = win
    @pos = pos
    @speed = 3
    @target = nil
    @size = 8
    @joystick_index = nil
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
      x = @pos.x + Stylet::Fee.cos(dir) * @speed
      y = @pos.y + Stylet::Fee.sin(dir) * @speed
      if (@win.rect.min_x..@win.rect.max_x).include?(x)
        @pos.x = x
      end
      if (@win.rect.min_y..@win.rect.max_y).include?(y)
        @pos.y = y
      end
    end

    @win.draw_rect(Stylet::Rect.new(@pos.x - @size, @pos.y - @size, @size * 2, @size * 2))
  end
end
