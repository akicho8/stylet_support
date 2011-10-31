# -*- coding: utf-8 -*-
require "environment"

Library = {
  :title => "青の渡し",
  :controller => SimulateWithSoundController.new,
  :pattern => "b",
  :field => <<-EOT,
  .b..b..bb.
  .b..b..bbb
  bb..b..bbb
  bb..b..bbb
  bb..b..bbb
  cb..b..cbc
  bc..c..bcb
  cb..b..cbc
  bc..c..bcb
  EOT
  :input => <<-EOT,
  _ AC r| Ar d *
  _ AC l| Bl d *
  EOT
}

if $0 == __FILE__
  Simulator.start(Library)
end
