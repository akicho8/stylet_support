# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "environment"))

Library = {
  :title => "水色の渡し",
  :controller => SimulateWithSoundController.new,
  :pattern => "cc",
  :field => <<-EOT,
  .b..b..bb.
  bb..b..bbb
  bc..b..cbc
  cb..c..bcb
  bc..b..cbc
  cb..c..bcb
  bc..b..cbc
  cb..c..bcb
  bc..b..cbc
  cb..c..bcb
  EOT
  :input => <<-EOT,
  _ AC r| Ar d *
  _ AC l| Bl d *
  EOT
}

if $0 == __FILE__
  Simulator.start(Library)
end
