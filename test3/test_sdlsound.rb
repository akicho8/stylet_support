# -*- coding: utf-8 -*-
# 問題点
# 1回目の再生でプロセスは止まる。でも2回目ではとまらなかったりする。
# フェイドインさせると必ずプロセスは止まらない。

require "test/unit"

$LOAD_PATH << ".."
require "config"
require "sdl_sound"

class TestSdlSoundWaveHash < Test::Unit::TestCase
  def test_play
    wavfiles = Dir[File.join(File.dirname(__FILE__), "sample.wav")]
    assert_equal(["./sample.wav"], wavfiles)

    @obj = SdlSound::WaveStock.new(wavfiles)
    @obj["sample"].play
    sleep(1)
    assert_equal(true, @obj["sample"].play?)
    @obj["sample"].halt
    assert_equal(false, @obj["sample"].play?)
  end

  def test_sample_play
    obj = SdlSound::WaveStock.new(Dir[File.join(CONFIG[:sounddir], "next*.wav")])
    obj.each_value{|e|
      e.play
      nil while e.play?
    }
  end
end

class TestSdlSoundMusic < Test::Unit::TestCase
  SampleMP3 = File.join(File.dirname(__FILE__), "sample.mp3")

  def test_play
    SdlSound.initialize
    SdlSound::Music.play(SampleMP3)
    sleep(2)
    assert_equal(true, SdlSound::Music.play?)
    SdlSound::Music.halt
    assert_equal(false, SdlSound::Music.play?)
  end

  # プロセスが死なない
  def test_fade_in_out
    SdlSound.initialize
    SdlSound::Music.fade_in(SampleMP3, 1000*3)
    sleep(4)
    SdlSound::Music.fade_out(1000*3)
    sleep(3)
  end
end


class Test_SDL_Mixer < Test::Unit::TestCase
  SampleMP3 = File.join(File.dirname(__FILE__), "sample.mp3")

  def setup
    begin
      SDL.inited_system(SDL::INIT_AUDIO)
      SDL::Mixer.open(44100)
    rescue SDL::Error
    end
  end

  # フェイドインを使わなければプロセスは終了する
  def test_process_ok
    SDL::Mixer.play_music(SDL::Mixer::Music.load(SampleMP3), -1)
    sleep(3)
    SDL::Mixer.halt_music
  end

  # しかしフェイドインを使用するとプロセスは終了しない(でも sample.wav だと終了する)
  def test_process_all_the_time
    SdlSound::Music.fade_in(SampleMP3, 1000*3)
    sleep(4)
    SDL::Mixer.halt_music
  end
end
