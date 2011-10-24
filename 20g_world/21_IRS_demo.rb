#!/usr/local/bin/ruby -Ku
require "environment"

Library = {
  :title => "IRSが必要になるケース",
  :controller => SimulateWithSoundController.new,
  :pattern => "bb",
  :field => <<-EOS,
  ...o......
  ...o......
  bb.oo.r.o.
  bbbyy.r.o.
  bbbyy.r.oo
  EOS
}

if $0 == __FILE__
  Simulator.start(Library)
end
