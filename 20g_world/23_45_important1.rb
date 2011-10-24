#!/usr/local/bin/ruby -Ku
require "environment"

Library = {
  :title => "45列目重要",
  :controller => SimulateWithSoundController.new,
  :pattern => "rc",
  :field => <<-EOS,
  .bbb.bbb..
  bbbb.bbb..
  bbbbbbbb..
  bbbbbbbbb.
  bbbbbbbbb.
  bbbbbbbbb.
  bbbbbbbbb.
  EOS
}

if $0 == __FILE__
  Simulator.start(Library)
end
