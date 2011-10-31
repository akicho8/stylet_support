require File.expand_path(File.join(File.dirname(__FILE__), "tgm_mode"))

class TGM20GController < TGMController
  def initialize
    super
    @mode_name = "TGM20G"
    @base_speed = 20.0
  end
end

module Modes
  class FrameTGM20G < MementFrame
    Name = "TGM 20G"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, TGM20GController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameTGM20G.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
