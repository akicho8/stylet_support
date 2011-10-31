require File.expand_path(File.join(File.dirname(__FILE__), "tap_master_20g_mode"))

class Master20GNoIRSController < Master20GController
  def initialize
    super
    @mode_name = "MASTER20G No IRS"
    @irs_enable = false
  end
end

module Modes
  class FrameMaster20GNoIRS < MementFrame
    Name = "MASTER 20G No IRS"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, Master20GNoIRSController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameMaster20GNoIRS.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
