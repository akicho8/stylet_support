#!/usr/local/bin/ruby -Ku
require "environment"

Library = {
  :title => "45列目重要",
  :controller => SimulateWithSoundController.new,
  :pattern => "br",
  :field => <<-EOS,
  ..b.......
  ..bbbbbbbb
  ..bbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  .bbbbbbbbb
  EOS
}

if $0 == __FILE__
  Simulator.start(Library)
end
