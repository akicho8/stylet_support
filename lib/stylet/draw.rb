# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), "screen_accessors"))

module Stylet
  module Draw
    include ScreenAccessors

    attr_accessor :count, :check_fps, :sdl_event, :screen_rect

    def initialize
      super
      @init_mode |= SDL::INIT_VIDEO
    end

    def before_main_loop
      super

      @count = 0
      @check_fps = CheckFPS.new

      options = SDL::HWSURFACE | SDL::DOUBLEBUF
      if Config[:full_screen]
        options |= SDL::FULLSCREEN
      end
      w, h = Config[:screen_size]
      @screen ||= SDL::Screen.open(w, h, Config[:color_depth], options)
      @screen_rect = Rect.new(0, 0, @screen.w, @screen.h)

      if Config[:background] && Config[:background_image]
        unless @backgroud_image
          background_image = Pathname(File.expand_path(File.join(File.dirname(__FILE__), "assets", Config[:background_image])))
          if background_image.exist?
            @backgroud_image = SDL::Surface.load_bmp(background_image)
            if false
              # これを設定すると黒色は透明色になって描画されない
              @backgroud_image.set_color_key(SDL::SRCCOLORKEY, 0)
            end
            @backgroud_image = @backgroud_image.display_format
          end
        end
      end

      background_clear

      if Stylet.sge_support?
        # SGE関係でウィンドウを自動ロックさせる(これは必要なのか？)
        SDL.autoLock = true
      end
    end

    def before_draw
    end

    def after_draw
      # ハードウェアがダブルバッファ対応の場合、flipで自動的にVSYNCを待って切り替えるので、ハードウェアのフレーム数(60FPS)以上にはならないことに注意
      @screen.flip
      @count += 1
    end

    def after_main_loop
      super
      if @screen
        @screen.destroy
        @screen = nil
      end
      if @backgroud_image
        @backgroud_image.destroy
        @backgroud_image = nil
      end
    end

    def title=(title)
      SDL::WM::set_caption(title, title)
    end

    def polling
      if @sdl_event = SDL::Event.poll
        case @sdl_event
        when SDL::Event::Quit # Window の X が押されたとき
          throw :exit, :break
        when SDL::Event::KeyDown
          if @sdl_event.sym == SDL::Key::ESCAPE || @sdl_event.sym == SDL::Key::Q
            throw :exit, :break
          end
        end
      end
    end

    def key_down?(key_sym)
      if @sdl_event.kind_of? SDL::Event::KeyDown
        @sdl_event.sym == key_sym
      end
    end

    def draw_line(x0, y0, x1, y1, color = "white")
      @screen.draw_line(x0, y0, x1, y1, Palette[color])
    end

    def draw_rect(x, y, w, h, color = "white")
      @screen.draw_rect(x, y, w, h, Palette[color])
    end

    def fill_rect(x, y, w, h, color = "white")
      @screen.fill_rect(x, y, w, h, Palette[color])
    end

    def draw_line2(p0, p1, color = "white")
      @screen.draw_line(p0.x, p0.y, p1.x, p1.y, Palette[color])
    end

    def draw_rect2(rect, color = "white")
      @screen.draw_rect(rect.x, rect.y, rect.w, rect.h, Palette[color])
    end

    def fill_rect2(rect, color = "white")
      @screen.fill_rect(rect.x, rect.y, rect.w, rect.h, Palette[color])
    end

    def save_bmp(fname)
      @screen.save_bmp(fname)
    end

    def system_line
      "#{@count} #{@check_fps.update.fps} FPS"
    end

    def before_update
      super
      vputs(system_line)
    end

    private

    def background_clear
      if @backgroud_image
        SDL::Surface.blit(@backgroud_image, min_x, min_y, width, height, @screen, 0, 0)
      else
        fill_rect(0, 0, width, height, "background")
      end
    end
  end
end
