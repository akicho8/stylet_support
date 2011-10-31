require File.expand_path(File.join(File.dirname(__FILE__), "tap_master_mode"))
require File.expand_path(File.join(File.dirname(__FILE__), "tgm_debug_mode"))

module Modes
  class FrameMaster2P < MementFrame
    Name = "Multi 2P Master Solo"
    def initialize
      @fields = [
        Field.create,
        Field.create,
      ]
      pat = Pattern::HistoryRec.new
      @players = [
        Player.new(@fields[0], 4,  Players::Player1.new, pat.clone, MasterController.new),
        Player.new(@fields[1], 4,  Players::Player2.new, pat.clone, MasterController.new),
      ]
    end
  end

  class FrameMaster2PDebug < MementFrame
    Name = "Multi 2P Master Solo Debug"
    def initialize
      @fields = [
        Field.create,
        Field.create,
      ]
      pat = Pattern::HistoryRec.new
      @players = [
        Player.new(@fields[0], 4, Players::Player1.new, pat.clone, MasterDebugController.new),
        Player.new(@fields[1], 4, Players::Player2.new, pat.clone, MasterDebugController.new),
      ]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameMaster2P.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
