$LOAD_PATH << ".." if $0 == __FILE__
require "shooting"

module BulletTrigger
  def compute
    super
    dir = Fee.angle(@x, @y, @target.x, @target.y)
    if (joy && joy.button(0))
      if @count.modulo(60 / 6).zero?
        @win.bullets << Bullet.new(@win, @x, @y, dir, 3.00)
      end
    end
  end
end

class GunShipA < GunShip1
  include BulletTrigger
end

class GunShipB < GunShip2
  include BulletTrigger
end

class Application < WarSpace
  def initialize
    super
    @draw_inst = Stylet::Sdl::Draw.instance
    ship1 = GunShipA.new(self, @draw_inst.width / 2, @draw_inst.height / 8 * 1)
    ship2 = GunShipB.new(self, @draw_inst.width / 2, @draw_inst.height / 8 * 7)
    ship1.target = ship2
    ship2.target = ship1
    @ships << ship1
    @ships << ship2
  end
end

Application.new.run
