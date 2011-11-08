#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "environment"))

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
