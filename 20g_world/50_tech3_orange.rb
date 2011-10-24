#!/usr/local/bin/ruby -Ku
require "environment"

Library = {
  :title => "橙の渡し",
  :controller => SimulateWithSoundController.new,
  :pattern => "o",
  :field => <<-EOS,
  .oo..o....
  ooo..o....
  ooo..o....
  ooo..o....
  ooo..o....
  ooo..o....
  oooo.o..o.
  ooo..o..o.
  oooooo..oo
  EOS
  :input => <<-EOS,
  _ AC r| Ar d *
  _ AC l| Bl d *
  EOS
}

if $0 == __FILE__
  Simulator.start(Library)
end
