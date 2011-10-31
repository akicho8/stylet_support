class TGMController
  def level_count_increment_signal(*args)
    super
    if level_max == 999 && @level_count == 480
      music_call("bgm", false) if respond_to?(:music_call)
    end
  end
end

class WavePlayer
  def event_name_to_wave_basename(name)
    name
  end
end

class MusicPlayer
  def event_name_to_music_filename(name)
    {
      "bgm" => "bgm.wav",
      "bgmmg" => "bgmmg.wav",
    }.fetch(name){
      "#{name}.mp3"
    }
  end
end
