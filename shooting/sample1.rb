$LOAD_PATH << ".." if $0 == __FILE__
require "shooting"

module ShipleBullet
  def compute
    super
    dir = Math2.rdirf(@x, @y, @target.x, @target.y)
    if (joy && joy.button(0))
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
