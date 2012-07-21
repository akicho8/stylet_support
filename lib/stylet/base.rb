# -*- coding: utf-8 -*-

require "rubygems"
require "sdl"
require "singleton"
require "pp"
require "pathname"

require_relative "config"

# 汎用ライブラリ
require File.expand_path(File.join(File.dirname(__FILE__), "color"))
require File.expand_path(File.join(File.dirname(__FILE__), "vsync_wait"))
require File.expand_path(File.join(File.dirname(__FILE__), "check_fps"))
require File.expand_path(File.join(File.dirname(__FILE__), "logger"))
require File.expand_path(File.join(File.dirname(__FILE__), "vector"))
require File.expand_path(File.join(File.dirname(__FILE__), "rect"))
require File.expand_path(File.join(File.dirname(__FILE__), "fee"))
require File.expand_path(File.join(File.dirname(__FILE__), "collision_support"))
require File.expand_path(File.join(File.dirname(__FILE__), "etc"))

# 描画系
require File.expand_path(File.join(File.dirname(__FILE__), "core"))
require File.expand_path(File.join(File.dirname(__FILE__), "system_pause"))
require File.expand_path(File.join(File.dirname(__FILE__), "cl_options"))
require File.expand_path(File.join(File.dirname(__FILE__), "draw"))
require File.expand_path(File.join(File.dirname(__FILE__), "font"))

# 描画サポート
require File.expand_path(File.join(File.dirname(__FILE__), "draw_support/circle"))
require File.expand_path(File.join(File.dirname(__FILE__), "draw_support/polygon"))
require File.expand_path(File.join(File.dirname(__FILE__), "draw_support/arrow"))

# 入力系
require File.expand_path(File.join(File.dirname(__FILE__), "joystick"))
require File.expand_path(File.join(File.dirname(__FILE__), "keyboard"))
require File.expand_path(File.join(File.dirname(__FILE__), "mouse"))

# オーディオ系
require File.expand_path(File.join(File.dirname(__FILE__), "audio"))

module Stylet
  #
  # スペックを配列で返す
  #
  def self.spec
    return @spec if @spec
    @spec ||= []
    @spec << "SGE" if sge_support?
    @spec << "MPEG" if SDL.constants.include?("MPEG")
    @spec << "Mixer" if SDL.constants.include?("Mixer")
    @spec << "GL" if SDL.constants.include?("GL")
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
