#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-

require "rubygems"
require "sdl"
require "singleton"

class SDL::Mixer::Wave
  def marshal_dump
  end
  def marshal_load(obj)
  end
end

module SdlSound

  #
  # 共通の初期化
  #
  def initialize
    return if @sdl_sound_initialized
    SDL.inited_system(SDL::INIT_AUDIO)
    SDL::Mixer.open(44100)
    @sdl_sound_initialized = true
  end

  # 全てのサウンド停止
  def halt
    SDL::Mixer.halt_music
  end

  module_function :initialize, :halt

  #
  # Waveデータ
  #
  class Wave < Struct.new(:ch, :wave)
    def play
      SDL::Mixer.play_channel(self.ch, self.wave, 0)
    end

    def play?
      SDL::Mixer.play?(self.ch)
    end

    def halt
      SDL::Mixer.halt(self.ch)
    end
  end

  #
  # 複数のWaveデータを管理するHash
  #
  class WaveStock < Hash
    include Singleton

    def initialize
      super
      SdlSound.initialize

      # (Dir[File.join(CONFIG[:sounddir], "next*.wav")])
      files = [
        "next_b.wav",
        "next_c.wav",
        "next_g.wav",
        "next_o.wav",
        "next_p.wav",
        "next_r.wav",
        "next_y.wav",

        "irs.wav",
        "lock.wav",
        "collision.wav",

        "delete_l.wav",
        "delete_s.wav",
        "field_down.wav",
        "gameover.wav",
        "grade_up.wav",
        "section_up.wav",

        "applause_l.wav",
        "applause_m.wav",
        "applause_s.wav",

        # "bgm.wav",
        # # "bgmmg.wav",
        # # "bgmmn.wav",
        # # "bgmtr.wav",
        # # "bgmtt.wav",
        # # "bgmvs.wav",
        # "mappy.mp3",
      ].collect{|filename|File.join(CONFIG[:sounddir], filename)}

      load_files(files)
    end

    def load_files(files)
      return if @files
      @files = files
      @channel_count = SDL::Mixer.allocateChannels(@files.size)
      @files.each_with_index{|fname, i|
        basename = File.basename(fname, ".wav")
        self[basename] = Wave.new(i, SDL::Mixer::Wave.load(fname))
      }
    end

    def wait
      nil while self.find{|e|e.play?}
    end

    def inspect
      out = ""
      out << "spec=#{SDL::Mixer.spec.inspect}\n"
      out << "@channel_count=#{@channel_count.inspect}\n"
      out << "keys=#{keys.inspect}"
    end
  end

  #
  # mp3,wav,mod等を再生する(再生できるチャンネルは1つだけ)
  #
  module Music
    module_function
    def play(fname)
      # p ">Music.play"
      SDL::Mixer.play_music(SDL::Mixer::Music.load(fname), -1)
      # p "<Music.play"
    end

    def play?
      SDL::Mixer.play_music?
    end

    def halt
      SDL::Mixer.halt_music
    end

    def fade_in(fname, ms=1000)
      SDL::Mixer.fade_in_music(SDL::Mixer::Music.load(fname), -1, ms)
    end

    def fade_out(ms=1000)
      SDL::Mixer.fade_out_music(ms)
    end
  end
end

if $0 == __FILE__
  require '../../config'
  # SdlSound::WaveStock.instance.load_files(Dir[File.join(CONFIG[:sounddir], "next*.wav")])
  SdlSound::WaveStock.instance.each_value{|e|
    e.play
    nil while e.play?
  }
end
