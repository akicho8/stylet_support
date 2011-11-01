require File.expand_path(File.join(File.dirname(__FILE__), "../lib/ruby_tetris"))

frame = Modes::FrameMaster.new
frame.players.each{|player|
  SignalRecoder.new(player.controller)
  WavePlayer.new(player.controller)
  MusicPlayer.new(player.controller)
}
UI::DrawAll.new(frame)
frame.start
