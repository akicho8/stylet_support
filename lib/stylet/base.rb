# -*- coding: utf-8 -*-

require "sdl"
require "singleton"
require "pp"
require "pathname"

require_relative "config"

# 汎用ライブラリ
require_relative "palette"
require_relative "vsync_wait"
require_relative "check_fps"
require_relative "logger"
require_relative "vector"
require_relative "rect"
require_relative "fee"
require_relative "collision_support"
require_relative "etc"

# 描画系
require_relative "core"
require_relative "system_pause"
require_relative "cl_options"
require_relative "draw"
require_relative "font"

# 描画サポート
require_relative "draw_support/circle"
require_relative "draw_support/polygon"
require_relative "draw_support/arrow"

# 入力系
require_relative "joystick"
require_relative "keyboard"
require_relative "mouse"

# オーディオ系
require_relative "audio"

module Stylet
  #
  # スペックを配列で返す
  #
  def self.spec
    return @spec if @spec
    @spec ||= []
    @spec << "SGE" if sge_support?
    @spec << "MPEG" if SDL.constants.include?(:MPEG)
    @spec << "Mixer" if SDL.constants.include?(:Mixer)
    @spec << "GL" if SDL.constants.include?(:GL)
    @spec
  end

  #
  # SGEの機能が使えるか?
  #
  def self.sge_support?
    SDL.respond_to?(:autoLock)
  end

  #
  # 全機能入りのクラス
  #
  #   Stylet::Base.main_loop do |win|
  #     win.vputs("Hello, World")
  #   end
  #
  class Base
    include Singleton
    include Core
    include Logger
    include Draw
    include DrawSupport
    include Font
    include Joystick
    include Keyboard
    include Mouse
    include SystemPause
    include ClOptions

    def self.main_loop(*args, &block)
      instance.public_send(__method__, *args, &block)
    end
  end
end

if $0 == __FILE__
  p Stylet.spec
  count = 0
  Stylet::Base.main_loop do |win|
    win.vputs(count += 1)
  end
end
