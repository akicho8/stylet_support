# -*- coding: utf-8 -*-
#
# SDL関連
#

require "rubygems"
require "sdl"
require "singleton"
require "pp"
require "pathname"
require "active_support/core_ext/string"

require File.expand_path(File.join(File.dirname(__FILE__), "config"))
require File.expand_path(File.join(File.dirname(__FILE__), "color"))
require File.expand_path(File.join(File.dirname(__FILE__), "vsync"))
require File.expand_path(File.join(File.dirname(__FILE__), "joy_base"))

module UI
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

  module Joystick
    attr_reader :joys

    def initialize
      super
      @init_mode |= SDL::INIT_JOYSTICK
    end

    def resource_init
      super
      puts "SDL::Joystick.num: #{SDL::Joystick.num}"
      @joys = (0...SDL::Joystick.num).collect{|i|JoyBase.create(SDL::Joystick.open(i))}
    end

    def polling
      super
      SDL::Joystick.updateAll
    end

    def inspect_display
      super
      @joys.each_with_index{|js_obj, index|
        vprint(js_obj.inspect_string)
      }
    end
  end

  module Font
    attr_accessor :pos

    def resource_init
      super
      SDL::TTF.init
      if CONFIG[:font_name]
        font_file = File.expand_path(File.join(File.dirname(__FILE__), CONFIG[:font_name]))
        @font = SDL::TTF.open(font_file, CONFIG[:font_size])
        unless @font
          raise "ファイルが見つかりません : #{@font}"
        end
        # @font.style = SDL::TTF::STYLE_BOLD
      end
    end

    def gprint(x, y, str)
      return unless str
      if @font
        @font.drawBlendedUTF8(@screen, str.to_s, x, y, *UI::Color::Palette["font"])
      end
    end

    def vprint(str)
      return unless str
      gprint(0, @pos * 16, str)
      @pos += 1
    end

    def resource_close
      super
      if @font
        @font.close
      end
    end
  end

  module Draw
    attr_accessor :count, :check_fps, :sdl_event

    def initialize
      super
      @init_mode |= SDL::INIT_VIDEO
    end

    def resource_init
      super

      @count = 0
      @check_fps = CheckFPS.new

      options = SDL::HWSURFACE | SDL::DOUBLEBUF
      if CONFIG[:full_screen]
        options |= SDL::FULLSCREEN
      end
      w, h = CONFIG[:screen_size]
      @screen ||= SDL.set_video_mode(w, h, 16, options)

      if CONFIG[:bmp_file]
        bmp_file = Pathname(File.expand_path(File.join(File.dirname(__FILE__), CONFIG[:bmp_file])))
        if bmp_file.exist?
          @backgroud_image = SDL::Surface.load_bmp(bmp_file)
          @backgroud_image.set_color_key(SDL::SRCCOLORKEY, 0)
          @backgroud_image = @backgroud_image.display_format
        end
      end

      bg_clear

      @event = SDL::Event.new
      if UI.sge_support?
        # SGE関係でウィンドウを自動ロックさせる
        SDL.autoLock = true
      end
    end

    def width
      @screen.w
    end

    def height
      @screen.h
    end

    def draw_begin
    end

    def draw_end
      # ハードウェアがダブルバッファ対応の場合、ここで自動的にVSYNCを待って切り替えるので 60 FPS 以上にはならない
      @screen.flip
    end

    def resource_close
      super
      @screen.destroy
      if @backgroud_image
        @backgroud_image.destroy
      end
    end

    def bg_clear
      if @backgroud_image
        SDL::Surface.blit(@backgroud_image, 0, 0, width, height, @screen, 0, 0)
      else
        fill_rect(0, 0, width, height, "bg")
      end
      @pos = 0
    end

    def set_title(title)
      begin
        SDL::WM::set_caption(title, title)
      rescue NameError
      end
    end

    def polling
      if @sdl_event = SDL::Event.poll
        case @sdl_event
        when SDL::Event::Quit # window close mark push
          throw :exit, :break
        when SDL::Event::KeyDown
          if @sdl_event.sym == SDL::Key::ESCAPE || @sdl_event.sym == SDL::Key::Q
            throw :exit, :break
          end
        end
      end
    end

    def draw_line(x, y, w, h, color)
      @screen.drawLine(x, y, w, h, Color::Palette[color])
    end

    def draw_rect(x, y, w, h, color)
      @screen.drawRect(x, y, w, h, Color::Palette[color])
    end

    def fill_rect(x, y, w, h, color)
      @screen.fillRect(x, y, w, h, Color::Palette[color])
    end

    def save_bmp(fname)
      @screen.save_bmp(fname)
    end

    def system_line
      "#{@count} #{@check_fps.update.fps} FPS"
    end

    def inspect_display
      super
      vprint(system_line)
    end
  end

  module Base
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def initialize
        @init_mode = 0
      end

      def resource_init
        SDL.init(@init_mode)
      end

      def resource_close
      end

      def inspect_display
      end

      def main_loop(&block)
        resource_init
        catch(:exit){
          loop do
            polling
            draw_begin
            bg_clear
            self.count += 1
            if block_given?
              block.call(self)
            end
            inspect_display
            draw_end
          end
        }
        resource_close
      end
    end
  end

  class Main
    include Singleton
    include Base
    include Draw
    include Font
    include Joystick
  end
end

if $0 == __FILE__
  p UI.spec
  UI::Main.instance.main_loop
end
