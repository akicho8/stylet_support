# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "environment"))

Library = {
  :title => "45列目重要",
  :controller => SimulateWithSoundController.new,
  :pattern => "rc",
  :field => <<-EOT,
  .bbb.bbb..
  bbbb.bbb..
  bbbbbbbb..
  bbbbbbbbb.
  bbbbbbbbb.
  bbbbbbbbb.
  bbbbbbbbb.
  EOT
}

if $0 == __FILE__
  Simulator.start(Library)
end
