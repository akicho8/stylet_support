#!/usr/local/bin/ruby -Ku
require "environment"

Library = {
  :title => "45列目を高くして振り分ける",
  :controller => SimulateWithSoundController.new,
  :pattern => "rbcypgorbcypgor",
  :field => <<-EOS,
  ..bbbb....
  .bbbbbb...
  .bbbbbbb..
  bbbbbbbbb.
  bbbbbbbbb.
  bbbbbbbbb.
  EOS
}

if $0 == __FILE__
  Simulator.start(Library)
end
