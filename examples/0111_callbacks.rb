# -*- coding: utf-8 -*-
require_relative "setup"

class App < Stylet::Base
  after_update { vputs "Hello, world."}
  after_update { vputs "Hello, world."}
  after_update { vputs "Hello, world."}
  main_loop
end
