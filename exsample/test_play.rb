# -*- compile-command: "rsdl test_play.rb" -*-

$LOAD_PATH << ".." if $0 == __FILE__

require "config"

require "tap_master_mode"
require "ui/frame"

require "signal_observer"
require "with_sound"

frame = Modes::FrameMaster.new
frame.players.each{|player|
  SignalRecoder.new(player.controller)
  WavePlayer.new(player.controller)
  MusicPlayer.new(player.controller)
}
UI::DrawAll.new(frame)
# UI::DrawAll.new(frame)
frame.start
