# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), "config"))
require File.expand_path(File.join(File.dirname(__FILE__), "logger"))

require "singleton"

module Stylet
  #
  # 曲関連
  #
  #   filename = File.expand_path(File.join(File.dirname(__FILE__), "assets/bgm.wav"))
  #   Stylet::Audio.instance.play(filename) # 曲再生
  #   p Stylet::Audio.instance.play?        #=> true (ループすることに注意)
  #   sleep(3)
  #   p Stylet::Audio.instance.fade_out      # フェイドアウト
  #   nil while Stylet::Audio.instance.play? # フェイドアウトするまで待つ
  #
  class Audio
    include Singleton

    #
    # 曲も効果音も必ず初期化することになる
    #
    def initialize
      SDL.initSubSystem(SDL::INIT_AUDIO)
      SDL::Mixer.open(Config[:sound_frequency])
      Stylet.logger.debug "driver_name: #{SDL::Mixer.driver_name}" if Stylet.logger
    end

    #
    # mp3,wav,mod等を再生する(再生できるチャンネルは1つだけ)
    #
    def play(fname)
      Stylet.logger.debug "play: #{fname}" if Stylet.logger
      SDL::Mixer.play_music(SDL::Mixer::Music.load(fname), -1)
    end

    #
    # 曲の再生中？
    #
    def play?
      SDL::Mixer.play_music?
    end

    #
    # すべてのサウンド停止
    #
    def halt
      SDL::Mixer.halt_music
    end

    #
    # フェイドインで入れる
    #
    def fade_in(fname, ms=1000)
      SDL::Mixer.fade_in_music(SDL::Mixer::Music.load(fname), -1, ms)
    end

    #
    # フェイドアウト
    #
    def fade_out(ms=1000)
      SDL::Mixer.fade_out_music(ms)
    end

    #
    # 効果音関連はここからアクセスする
    #
    #   Stylet::Audio.instance.se_stock.load_files(filenames...)
    #   Stylet::Audio.instance.se_stock["se"].play
    #
    def se_stock
      @se_stock ||= SeStock.new
    end

    #
    # 複数の効果音
    #
    class SeStock
      def initialize
        @files = {}
      end

      #
      # @files には直接アクセスさせない
      #
      #     Stylet::Audio.instance.se_stock["se"].play
      #
      def [](key)
        @files[key]
      end

      #
      # 複数ファイルの一括読み込み
      #
      def load_files(*file_names)
        [file_names].flatten.each{|file_name|
          load_file(file_name)
        }
      end

      #
      # 単体ファイルの読み込み
      #
      def load_file(file_name)
        file_name = Pathname(file_name).expand_path
        Stylet.logger.debug "load_file: #{file_name}" if Stylet.logger

        index = @files.size
        @channel_count = SDL::Mixer.allocate_channels(index.next)
        key = file_name.basename(".*").to_s
        @files[key] = SoundEffect.new(index, SDL::Mixer::Wave.load(file_name))
      end

      #
      # いずれかの効果音が再生中なら終わるまで待つ(デバッグ用)
      #
      def wait
        nil while @files.values.any?{|e|e.play?}
      end

      def inspect
        out = ""
        out << "spec=#{SDL::Mixer.spec.inspect}\n"
        out << "@channel_count=#{@channel_count.inspect}\n"
        out << "@files.keys=#{@files.keys.inspect}"
      end

      #
      # 効果音一つ
      #
      class SoundEffect
        def initialize(ch, wave)
          @ch = ch
          @wave = wave
        end

        def play
          SDL::Mixer.play_channel(@ch, @wave, 0)
        end

        def play?
          SDL::Mixer.play?(@ch)
        end

        def halt
          SDL::Mixer.halt(@ch)
        end
      end
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../stylet"))

  filename = File.expand_path(File.join(File.dirname(__FILE__), "assets/bgm.wav"))
  Stylet::Audio.instance.play(filename)
  p Stylet::Audio.instance.play?
  sleep(3)
  p Stylet::Audio.instance.fade_out
  nil while Stylet::Audio.instance.play?

  filename = File.expand_path(File.join(File.dirname(__FILE__), "assets/se.wav"))
  Stylet::Audio.instance.se_stock.load_file(filename)
  Stylet::Audio.instance.se_stock["se"].play
  Stylet::Audio.instance.se_stock.wait
end
