#!/usr/local/bin/ruby -Ku
require "environment"

Library = {
  :title => "青の渡し",
  :controller => SimulateWithSoundController.new,
  :pattern => "b",
  :field => <<-EOS,
  .b..b..bb.
  .b..b..bbb
  bb..b..bbb
  bb..b..bbb
  bb..b..bbb
  cb..b..cbc
  bc..c..bcb
  cb..b..cbc
  bc..c..bcb
  EOS
  :input => <<-EOS,
  _ AC r| Ar d *
  _ AC l| Bl d *
  EOS
}

if $0 == __FILE__
  Simulator.start(Library)
end
