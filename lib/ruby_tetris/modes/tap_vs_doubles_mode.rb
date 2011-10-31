require File.expand_path(File.join(File.dirname(__FILE__), "tap_vs_mode"))

module Modes
  class FrameDoublesVersus < MementFrame
    Name = "4P MASTER DOUBLES VS"
    def initialize
      @fields = [
        Field.new([14, 20+Field::INVISIBLE_AREA]),
        Field.new([14, 20+Field::INVISIBLE_AREA]),
      ]
      vs_ctrl = [
        VersusController.new,
        VersusController.new,
      ]
      @players = [
        Player.new(@fields[0], 4, Players::Player1.new, Pattern::HistoryRec.new, vs_ctrl[0]),
        Player.new(@fields[0],10, Players::Player2.new, Pattern::HistoryRec.new, vs_ctrl[0]),
        Player.new(@fields[1], 4, Players::Player1.new, Pattern::HistoryRec.new, vs_ctrl[1]),
        Player.new(@fields[1],10, Players::Player2.new, Pattern::HistoryRec.new, vs_ctrl[1]),
      ]
      @players[0].controller.target_player = @players[2]
      @players[2].controller.target_player = @players[0]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameDoublesVersus.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
