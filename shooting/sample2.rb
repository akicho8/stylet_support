# -*- coding: utf-8 -*-
$LOAD_PATH << ".." if $0 == __FILE__
require "shooting"

# 狙い撃ち弾
# n-way弾
# 円形弾
# 分裂弾
# 誘導弾
# 誘導レーザー
# ミサイル
# 加速弾
# 落下弾
# 狙い撃ち弾+回転弾      # 回転弾が自機を狙う
# 渦巻き弾
# 停止する誘導弾
# 直進するビーム

module BulletDir
  def compute
    super
    @target_dir = Math2.rdirf(@x, @y, @target.x, @target.y)
  end
end

module BulletNeraiutidan
  def compute
    super
    if @base.press_button?(SDL::Key::K1) || (joy && joy.button(0))
      if @count.modulo(60 / 10).zero?
        @base.bullets << Bullet.new(@base, @x, @y, @target_dir, 5.00)
      end
    end
  end
end

class Bullet2 < BulletBase
  include CircleGrid

  def initialize(target, *args)
    @target = target
    super(*args)
  end

  def compute
    compute_sincos
    unless @base.pause_mode
      if @count.modulo(1).zero?
        d = Math2.rdirf(@x, @y, @target.x, @target.y)
        gap = (d - @dir) % 1.00
        if gap >= 0.5
          sign = -1
        else
          sign = +1
        end
        @dir = (@dir + (1.0 / 256) * sign) % 1.0
        @cx = @x
        @cy = @y
        @radius = @speed
        @speed += 0.1
      end
    end
  end
end

module BulletTuibi
  def compute
    super
    if @base.press_button?(SDL::Key::K2) || (joy && joy.button(1))
      div, mod = @count.divmod(60 / 10)
      if mod.zero?
        wide = 2
        @base.bullets << Bullet2.new(@target, @base, @x, @y, @target_dir + rand * 1.0 / wide - 1.0 / (wide * 2), 1.0)
      end
    end
  end
end

module Bullet3waydan
  def compute
    super
    if @base.press_button?(SDL::Key::K4) || (joy && joy.button(2))
      if @count.modulo(60 / 5).zero?
        gap = 1.0 / 64
        n = 3
        n.times{|i|
          d = @target_dir - (n / 2 * gap) + gap * i
          @base.bullets << Bullet.new(@base, @x, @y, d, 5.00)
        }
      end
    end
  end
end

module BulletRandom
  def compute
    super
    if @base.press_button?(SDL::Key::K3) || (joy && joy.button(3))
      if @count.modulo(60 / 20).zero?
        z = 1.0 / 24
        d = @target_dir + (rand * z - z / 2) * 2
        @base.bullets << Bullet.new(@base, @x, @y, d, 7)
      end
    end
  end
end

module BulletUzumaki
  def initialize(*)
    super
    @uzumaki_count = 0
  end

  def compute
    super
    if @base.press_button?(SDL::Key::K5) || (joy && joy.button(4))
      div, mod = @count.divmod(60 / 20)
      if mod.zero?
        n = 4
        n.times{|i|
          d = 1.0 / n * i + (Math2.rsinf(1.0 / 32 * div) * 0.1)
          @base.bullets << Bullet.new(@base, @x, @y, d, 2)
        }
      end
    end
  end
end

module BulletUzumakix2
  def compute
    super
    if @base.press_button?(SDL::Key::K6) || (joy && joy.button(5))
      div, mod = @count.divmod(60 / 10)
      if mod.zero?
        uzumaki2(div, +1)
        uzumaki2(div, -1)
      end
    end
  end

  def uzumaki2(count, sign)
    n = 5
    gap = 1.0 / n
    n.times{|i|
      d = (n / 2 * gap) + gap * i + (count * 1.0 / 120 * sign) + (count * 0.001)
      @base.bullets << Bullet.new(@base, @x, @y, d, 2.0)
    }
  end
end

module Bullet128waydan
  def compute
    super
    if @base.press_button?(SDL::Key::K7) || (joy && joy.button(6))
      if @count.modulo(60 / 2).zero?
        n = 64
        gap = 1.0 / n
        n.times{|i|
          @base.bullets << Bullet.new(@base, @x, @y, gap * i, 4.00)
        }
      end
    end
  end
end

module BulletUzumakix2Fast
  def compute
    super
    if @base.press_button?(SDL::Key::K8) || (joy && joy.button(7))
      div, mod = @count.divmod(60 / 20)
      if mod.zero?
        uzumaki2fast(div, +1)
        uzumaki2fast(div, -1)
      end
    end
  end

  def uzumaki2fast(count, sign)
    n = 3
    gap = 1.0 / n
    n.times{|i|
      d = (n / 2 * gap) + gap * i + (count * 1.0 / 120 * sign) + (count * 0.001)
      @base.bullets << Bullet.new(@base, @x, @y, d, 6.0)
    }
  end
end

class GunShipA < GunShip1
  include BulletDir
  include BulletNeraiutidan
  include BulletTuibi
  include Bullet3waydan
  include BulletRandom
  include BulletUzumaki
  include BulletUzumakix2
  include Bullet128waydan
  include BulletUzumakix2Fast
end

class GunShipB < GunShip2
  include BulletDir
  include BulletNeraiutidan
  include BulletTuibi
  include Bullet3waydan
  include BulletRandom
  include BulletUzumaki
  include BulletUzumakix2
  include Bullet128waydan
  include BulletUzumakix2Fast
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
