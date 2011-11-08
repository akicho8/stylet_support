require File.expand_path(File.join(File.dirname(__FILE__), "../lib/ruby_tetris/all"))
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/ruby_tetris/simulator"))

class SimulateWithSoundController < SimulateController
  include SoundController

  def initialize(*args)
    super
    # lock_delay = 36
    lock_delay = nil
    @level_info = LevelInfo.new(speed || 20.0, 0.01, 26/2, 49/2, 15, lock_delay, 3)
    @mode_name = "DEMO"
    @start_delay = 60
  end
end
