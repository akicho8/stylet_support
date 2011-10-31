require File.expand_path(File.join(File.dirname(__FILE__), "tap_master_mode"))

class Master20GController < MasterController
  def initialize
    super
    @mode_name = "MASTER20G"
    @base_speed = 20.0
  end
end

module Modes
  class FrameMaster20G < MementFrame
    Name = "MASTER 20G"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, Master20GController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameMaster20G.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
