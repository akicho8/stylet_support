#!/usr/local/bin/ruby -Ku
require "environment"

Library = {
  :title => "水色の渡し",
  :controller => SimulateWithSoundController.new,
  :pattern => "cc",
  :field => <<-EOS,
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
  EOS
  :input => <<-EOS,
  _ AC r| Ar d *
  _ AC l| Bl d *
  EOS
}

if $0 == __FILE__
  Simulator.start(Library)
end
