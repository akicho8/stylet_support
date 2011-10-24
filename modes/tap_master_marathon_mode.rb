#!/usr/local/bin/ruby -Ku

$LOAD_PATH << ".." if $0 == __FILE__

require "tap_master_mode"

SegmentMaster20GMarathon = SegmentMaster[5] * 100

class Master20GMarathonController < Controller
  def initialize
    super
    init_level(SegmentMaster)
    @mode_name = "MASTER 20G Marathon"
  end
end

module Modes
  class FrameMaster20GMarathon < MementFrame
    Name = "MASTER 20G Marathon"

    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, Master20GMarathonController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameMaster20GMarathon.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
