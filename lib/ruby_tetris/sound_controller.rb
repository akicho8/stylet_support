# -*- coding: utf-8 -*-

require "observer"

require File.expand_path(File.join(File.dirname(__FILE__), "ui/sdl/sound"))
require File.expand_path(File.join(File.dirname(__FILE__), "signal_observer"))
require File.expand_path(File.join(File.dirname(__FILE__), "combo_controller"))

# 効果音を発生させたいという意思を通知するのみ
module SoundController
  include ComboController

  def initialize
    super
    # @wave_stock = SdlSound::WaveStock.new(Dir[File.join(CONFIG[:sounddir], "*.wav")])
    # SdlSound::Music.play(Pathname(__FILE__).dirname.join("sound/tap0.mp3").expand_path.to_s)

    WavePlayer.new(self)
    MusicPlayer.new(self)
  end

  def start_signal(*args)
    super
    # bgms = ["bgmmg", "tap2", "tap3"]
    # __music_call__(bgms.choice)
  end

  def mino_set_signal(player)
    super
    if player.current_mino
      one_char = player.current_mino.color.scan(/./).first
      __se_call__("next_#{one_char}")
    end
  end

  def max_velocity_fall_collision_signal
    super
    __se_call__("collision")
  end

  def fall_collision_signal
    super
    __se_call__("collision")
  end

  def lock_signal(player)
    super
    __se_call__("lock")
  end

  def signal_field_down_signal(player)
    super
    __se_call__("field_down")
  end

  def user_irs_success_signal(*args)
    super
    __se_call__("irs")
  end

  def lines_clear_signal(player)
    super
    line_count = player.field.complate_info.size
    if line_count <= 2
      __se_call__("delete_s")
    else
      __se_call__("delete_l")
    end
  end

  def combo_signal(count)
    __se_call__({0 => "applause_s", 1 => "applause_m"}.fetch(count, "applause_l"))
  end

  def game_over_start_signal(player)
    super
    __music_stop__
    __se_call__("gameover")
  end

  private

  def __se_call__(name)
    changed
    notify_observers("sound", "se", name, true)
  end

  def __music_call__(name)
    changed
    notify_observers("sound", "music", name, true)
  end

  def __music_stop__
    changed
    notify_observers("sound", "music", nil, false)
  end
end
