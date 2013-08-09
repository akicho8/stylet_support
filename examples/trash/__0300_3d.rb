# -*- coding: utf-8 -*-
#
# 3D
#
require_relative "helper"

class Scene
  def initialize(win)
    @win = win
    @points = []

    @points << Stylet::Vector3.new(-200, +200, 75)
    @points << Stylet::Vector3.new(+200, +200, 75)
    @points << Stylet::Vector3.new(+200, -200, 75)
    @points << Stylet::Vector3.new(-200, -200, 75)

    @points << Stylet::Vector3.new(-200, +200, 50)
    @points << Stylet::Vector3.new(+200, +200, 50)
    @points << Stylet::Vector3.new(+200, -200, 50)
    @points << Stylet::Vector3.new(-200, -200, 50)

    @ridges = [
      [0, 1],
      [1, 2],
      [2, 3],
      [3, 0],

      [4, 5],
      [5, 6],
      [6, 7],
      [7, 4],

      [0, 4],
      [1, 5],
      [2, 6],
      [3, 7],
    ]
    @hhh = 25
    @ydir = 0
  end

  def update
    @hhh += @win.axis.down.repeat - @win.axis.up.repeat

    # @pointsA.collect{|p|
    #   s = Stylet::Vector.new
    #   s.x = p.x * Stylet::Fee.cos(@ydir) - p.z * Stylet::Fee.sin(@ydir)
    #   s.x = p.x * Stylet::Fee.cos(@ydir) - p.z * Stylet::Fee.sin(@ydir)
    #   ((long)box2z[i].vx * rsin8(r)) / 128 + ((long)box2z[i].vz * rcos8(r)) / 128;
    #   box2y[i].vy = box2z[i].vy;
    # }
    # 
    # for (i=0; i<VERTEX_N; i++) {
    #     }

    @points2 = @points.collect{|p|
      Stylet::Vector.new(p.x.to_f * @hhh / p.z, p.y.to_f * @hhh / p.z)
    }
    @points3 = @points2.collect{|p|
      @win.rect.center + Stylet::Vector.new(p.x, -p.y)
    }
    @ridges.each{|a, b|
      @win.draw_line(@points3[a], @points3[b])
    }
    @points3.each_with_index{|p0, index|
      @win.vputs index, :vector => p0
    }
    @win.vputs "hhh=#{@hhh}"
  end
end

class App < Stylet::Base
  include Helper::CursorWithObjectCollection

  def before_main_loop
    super if defined? super
    self.title = "3D"
    # @cursor.display = false
    @objects << Scene.new(self)
  end
end

App.run
