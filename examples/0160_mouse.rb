# -*- coding: utf-8 -*-
require_relative "setup"
Stylet.run do
  vputs mouse
  draw_vector(mouse.vector, :origin => rect.center, :label => mouse.vector.length)
end
