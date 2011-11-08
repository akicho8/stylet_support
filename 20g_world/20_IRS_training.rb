require File.expand_path(File.join(File.dirname(__FILE__), "environment"))

class DemoIRSController < SimulateWithSoundController
  def initialize(*)
    super
    @mode_name = "IRS"
    wait = 30
    @level_info = LevelInfo.new(20.0, 0.01, wait+26/2, 49/2, wait+15, nil, 3)
  end
end

module Modes
  class FrameMasterSingleIRS < Frame
    Name = "Single IRS"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::History.new, DemoIRSController.new)]
    end
  end
end

frame = Modes::FrameMasterSingleIRS.new
UI::DrawAll.new(frame)
frame.start(60)
