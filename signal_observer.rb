#!/usr/local/bin/ruby -Ku

require "ui/sdl/sound"

class SignalRecoder
  attr_reader :record

  def initialize(target)
    target.add_observer(self)
    @record = []
  end

  def update(*args)
    @record << args
    p args
  end
end

class WavePlayer
  def initialize(target)
    target.add_observer(self)
    # @wave_stock = SdlSound::WaveStock.new(Dir[File.join(CONFIG[:sounddir], "*.wav")])
    @wave_stock = SdlSound::WaveStock.instance
  end

  def update(kind, se_music, name, play)
    # SdlSound::WaveStock.instance["next_c"].play
    if kind == "sound" && se_music == "se"
      # p [name, play, event_name_to_wave_basename(name)]
      # @wave_stock["next_b"].play
      if basename = event_name_to_wave_basename(name)
        if obj = @wave_stock[basename]
          if play
            obj.play
          else
            obj.halt
          end
        end
      end
    end
  end

  def close
    @wave_stock.each_value{|e|e.halt}
  end

  def event_name_to_wave_basename(name)
    nil
  end
end

class MusicPlayer
  def initialize(target)
    target.add_observer(self)
    SdlSound.initialize
  end

  def update(kind, se_music, name, play)
    return unless kind == "sound" && se_music == "music"
    unless play
      SdlSound::Music.halt
    else
      name = event_name_to_music_filename(name)
      if name
        name = File.join(CONFIG[:sounddir], name)
        if File.exist?(name)
          unless SdlSound::Music.play?
            SdlSound::Music.play(name)
          end
        end
      end
    end
  end

  def close
    SdlSound::Music.halt
  end

  def event_name_to_music_filename(name)
    nil
  end
end
