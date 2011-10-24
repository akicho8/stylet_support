#!/usr/local/bin/ruby -Ku
# SDL関連

#
# クラス設計方針
#
# - Gdk版と共通のメソッドを持たせる。
# - 全てのメソッドを抽象化したインターフェイスにする。
# - サブクラスでSDLに依存する処理を記述させてはならない。
# - SDL関連の全責任を負う。

require "rubygems"
require "sdl"
require "singleton"
require "pp"

$LOAD_PATH << "../.." if $0 == __FILE__
require "config"
require "ui/abstract"
require "ui/color"
require "vsync"

module UI
  module Sdl
    class JoyBase
      def self.create(object)
        table = {
          "USB Gamepad" => JoyElecomUsbPad,
        }
        name = SDL::Joystick.index_name(object.index).strip
        table[name].new(object)
      end

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
        if dir
          1.0 / 8 * dir
        end
      end

      def inspect_string
        button_str = (0...@object.num_buttons).collect{|button_index|
          if @object.button(button_index)
            "[#{button_index}]"
          else
            " #{button_index} "
          end
        }
        "[#{@object.index}] #{name} %4d %4d #{@object.num_buttons} #{@object.index} #{button_str}" % [@object.axis(x_index), @object.axis(y_index)]
      end
    end

    class JoyElecomUsbPad < JoyBase
      def x_index
        3
      end
      def y_index
        4
      end
    end

    class JoyStickUtils
      include Singleton

      attr_reader :joys

      def initialize(*)
        super
        # p SDL::Joystick.update_all
        puts "SDL::Joystick.num: #{SDL::Joystick.num}"
        @joys = (0...SDL::Joystick.num).collect{|i|JoyBase.create(SDL::Joystick.open(i))}
      end

      def inspect_display
        @joys.each_with_index{|js_obj, index|
          UI::Sdl::Draw.instance.gprint(0, 16 * 1 + index * 16, js_obj.inspect_string)
        }
      end

      def update
        # SDL::Joystick.updateAll
      end
    end

    def spec
      list = []
      list << "SGE" if UI::Sdl.sge_support?
      list << "MPEG" if SDL.constants.include?("MPEG")
      list << "Mixer" if SDL.constants.include?("Mixer")
      list << "GL" if SDL.constants.include?("GL")
      list
    end
    module_function :spec

    # SGEの機能が使えるか?
    def sge_support?
      ::SDL.respond_to?(:autoLock)
    end
    module_function :sge_support?

    module Font
      def init_font
        # フォント初期化
        SDL::TTF.init
        @font = SDL::TTF.open(CONFIG[:font], CONFIG[:font_size])
        fail "フォントが見付からない" unless @font
        @font.style = SDL::TTF::STYLE_BOLD
      end

      def gprint(x, y, str)
        return unless str
        @font.drawBlendedUTF8(@screen, str.to_s, x, y, *UI::Color::Palette['font'])
      end
    end

    module JoystickMethods
      def init_joy
        UI::Sdl::JoyStickUtils.instance
      end

      def joy_check
        # SDL::Joystick.updateAll
        if CONFIG[:joy_debug]
          UI::Sdl::JoyStickUtils.instance.inspect_display
        end
      end
    end

    class Draw < GuiAbstract
      include Font
      include JoystickMethods

      attr_accessor :count, :check_fps, :sdl_event

      def initialize
        super

        @count = 0
        @check_fps = CheckFPS.new

        # p ">Draw::initialize #{object_id}"

        SDL.init(SDL::INIT_VIDEO|SDL::INIT_JOYSTICK)
        w, h = CONFIG[:screen_size]
        # @screen = SDL::setVideoMode(w, h, 16, SDL::HWSURFACE|SDL::DOUBLEBUF)
        options = SDL::HWSURFACE | SDL::DOUBLEBUF
        if CONFIG[:full_screen]
          options |= SDL::FULLSCREEN
        end
        @screen ||= SDL.set_video_mode(w, h, 16, options)

        if false
          @backgroud_image = SDL::Surface.load_bmp(File.dirname(__FILE__) + "/../../tgm_backgrounds/ate-06_11.bmp")
          @backgroud_image.set_color_key(SDL::SRCCOLORKEY, 0)
          @backgroud_image = @backgroud_image.display_format
        end

        bg_clear

        @event = SDL::Event.new
        SDL.autoLock = true if Sdl.sge_support?        # SGE関係でウィンドウを自動ロックさせる

        init_font
        init_joy

        # SDL::Surface.blit($image, 0, 0, 32, 32, screen, @x, @y)

        # p "<Draw::initialize #{object_id}"
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
        joy_check
        @screen.flip # ハードウェアがダブルバッファ対応なら自動的にVSYNCを待って切り替えるので 60 FPS 以上にはならない
      end

      # Singleton でない場合は終了するときに呼ぶこと
      def close
        unless kind_of? Singleton
          @font.close
          @screen.destroy
          if @backgroud_image
            @backgroud_image.destroy
          end
        end
      end

      def pause
      end

      def bg_clear
        if @backgroud_image
          SDL::Surface.blit(@backgroud_image, 0, 0, width, height, @screen, 0, 0)
        else
          fill_rect(0, 0, width, height, "bg")
        end
      end

      def set_title(title)
        begin
          SDL::WM::set_caption(title, title)
        rescue NameError
        end
      end

      # ここでジョイスティックの情報も取得できるが、個別に別のところで取得している
      def polling
        if @sdl_event = SDL::Event.poll
          case @sdl_event
          when SDL::Event::Quit # window close mark push
            throw :exit, :break
          when SDL::Event::KeyDown
            if @sdl_event.sym == SDL::Key::ESCAPE or @sdl_event.sym == SDL::Key::Q
              throw :exit, :break
            end
          end
        end
      end

      def draw_line(x, y, w, h, color)
        return unless Sdl.sge_support?
        @screen.drawLine(x, y, w, h, Color::Palette[color])
      end

      def draw_rect(x, y, w, h, color)
        return unless Sdl.sge_support?
        @screen.drawRect(x, y, w, h, Color::Palette[color])
      end

      def fill_rect(x, y, w, h, color)
        return unless Sdl.sge_support?
        @screen.fillRect(x, y, w, h, Color::Palette[color])
      end

      def save_bmp(fname)
        @screen.save_bmp(fname)
      end

      def system_line
        "#{@count}  #{@check_fps.update.fps} FPS"
      end
      ######################################## 独自のメソッド
    end
  end
end

if $0 == __FILE__
  p UI::Sdl.spec

  1.times {
    g = UI::Sdl::Draw.instance
    catch(:exit){
      loop do
        g.polling
        g.draw_begin
        g.bg_clear
        g.count += 1
        g.gprint(0, 0, g.system_line)
        g.draw_end
      end
    }
    g.close
  }
end
