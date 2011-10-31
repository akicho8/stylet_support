# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), "tgm_mode"))
require File.expand_path(File.join(File.dirname(__FILE__), "tgm_plus_mode"))

SegmentMaster = [
  [1.0/128, 1.0/1024, 22, 32, 12, 36, 3],
  [1.0/32,  1.0/256,  22, 32, 12, 36, 3],
  [1.0/64,  1.0/128,  22, 32, 12, 36, 3],
  [1.0,     4.0/100,  22, 32, 12, 36, 3],
  [5.0,     0,        22, 32, 12, 36, 3],
  [20,      0,        21, 30, 11, 36, 3],
  [20,      0,        20, 28, 10, 36, 3],
  [20,      0,        19, 26,  9, 36, 3],
  [20,      0,        18, 20,  0, 25, 2],
  [20,      0,        16, 15,  0, 20, 1],
]

class MasterController < Controller
  def initialize
    super
    init_level(SegmentMaster)
    @mode_name = "MASTER"
  end
end

class MasterPlusController < MasterController
  include TGMPlus
  def initialize
    super
    @mode_name = "MASTER+"
    @plus.set_table(TGMPlusTable) # 必要
  end
end

module Modes
  class FrameMaster < MementFrame
    Name = "MASTER"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, MasterController.new)]
    end
  end

  class FrameMasterPlus < MementFrame
    Name = "MASTER+"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, MasterPlusController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameMaster.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
