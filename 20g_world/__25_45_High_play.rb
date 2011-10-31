#!/usr/local/bin/ruby -Ku
require "environment"

Library = {
  :title => "45列目を高くして振り分ける",
  :controller => SimulateWithSoundController.new,
  :pattern => "rbcypgorbcypgor",
  :field => <<-EOT,
  ..bbbb....
  .bbbbbb...
  .bbbbbbb..
  bbbbbbbbb.
  bbbbbbbbb.
  bbbbbbbbb.
  EOT
}

if $0 == __FILE__
  Simulator.start(Library)
end
