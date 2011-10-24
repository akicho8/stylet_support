#!/usr/local/bin/ruby -Ku

require File.expand_path(File.dirname(__FILE__) + "/../init")

require "tgm_debug_mode"
require "tds_mode"
require "tap_vs_doubles_mode"
require "tap_master_mode"
require "tap_master_20g_mode"
require "tap_death_swap_mode"
require "tap_master_multi_2p"
require "tap_extend_m_mode"
require "tap_extend_gm_mode"
require "tgm_mode"
require "tap_master_swap_mode"
require "tap_master_marathon_mode"
require "tap_vs_mode"
require "tgm_20g_mode"
require "tap_doubles_mode"
require "tap_death_mode"
require "tgm_plus_mode"

require "ui/sdl/input"
require "ui/frame"

require "simulator"
require "sound_controller"

require "signal_observer"
require "with_sound"

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
