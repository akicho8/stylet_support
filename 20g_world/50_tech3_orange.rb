# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "environment"))

Library = {
  :title => "橙の渡し",
  :controller => SimulateWithSoundController.new,
  :pattern => "o",
  :field => <<-EOT,
  .oo..o....
  ooo..o....
  ooo..o....
  ooo..o....
  ooo..o....
  ooo..o....
  oooo.o..o.
  ooo..o..o.
  oooooo..oo
  EOT
  :input => <<-EOT,
  _ AC r| Ar d *
  _ AC l| Bl d *
  EOT
}

if $0 == __FILE__
  Simulator.start(Library)
end
