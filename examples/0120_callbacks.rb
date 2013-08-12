# -*- coding: utf-8 -*-
require "./setup"

class App < Stylet::Base
  after_update { vputs "Hello, world."}
  after_update { vputs "Hello, world."}
  after_update { vputs "Hello, world."}
  run
end
