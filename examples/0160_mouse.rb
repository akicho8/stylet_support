# -*- coding: utf-8 -*-
require "./setup"
Stylet.run do
  vputs mouse
  draw_vector(mouse.vector, :origin => rect.center, :label => mouse.vector.length)
end
