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

  class JoyBase
    def self.create(object)
      correspondence_table = {
        "USB Gamepad"                => "joy_elecom_usb_pad",
        "PLAYSTATION(R)3 Controller" => "joy_play_station3",
      }
      name = SDL::Joystick.index_name(object.index).strip
      driver_name = correspondence_table[name]
      require File.expand_path(File.join(File.dirname(__FILE__), "drivers/#{driver_name}"))
      driver_name.classify.constantize.new(object)
    end

    attr_reader :object

    def initialize(object)
      @object = object
    end

    def index
      @object.index
    end

    def name
      SDL::Joystick.index_name(index)
    end

    def button(n)
      @object.button(n)
    end

    def x_index
      0
    end

    def y_index
      1
    end

    def lever_on?(dir)
      case dir
      when :up
        @object.axis(y_index) == -32768
      when :down
        @object.axis(y_index) == +32767
      when :right
        @object.axis(x_index) == +32767
      when :left
        @object.axis(x_index) == -32768
      else
        false
      end
    end

    def direction
      dir = nil
      if lever_on?(:up)
        if lever_on?(:right)
          dir = 7
        elsif lever_on?(:left)
          dir = 5
        else
          dir = 6
        end
      elsif lever_on?(:down)
        if lever_on?(:right)
          dir = 1
        elsif lever_on?(:left)
          dir = 3
        else
          dir = 2
        end
      elsif lever_on?(:right)
        dir = 0
      elsif lever_on?(:left)
        dir = 4
      end
      dir
    end

    def direction2
      if dir = direction
        1.0 / 8 * dir
      end
    end

    def button_str
      (0...@object.num_buttons).collect{|index|
        if @object.button(index)
          "#{index}"
        end
      }.join
    end

    def inspect_string
      "#{@object.index}: #{name.slice(/^.{8}/)} #{inspect2}"
    end

    def inspect2
      "DIR:#{direction} BTN:#{button_str} %+04d %+04d" % [@object.axis(x_index), @object.axis(y_index)]
    end
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
      font_file = File.expand_path(File.join(File.dirname(__FILE__), CONFIG[:font_name]))
      @font = SDL::TTF.open(font_file, CONFIG[:font_size])
      unless @font
        raise "ファイルが見つかりません : #{@font}"
      end
      # @font.style = SDL::TTF::STYLE_BOLD
    end

    def gprint(x, y, str)
      return unless str
      @font.drawBlendedUTF8(@screen, str.to_s, x, y, *UI::Color::Palette["font"])
    end

    def vprint(str)
      return unless str
      gprint(0, @pos * 16, str)
      @pos += 1
    end

    def resource_close
      super
      @font.close
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

    # Singleton でない場合は終了するときに呼ぶこと
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
