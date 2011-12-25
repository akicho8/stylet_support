# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), "screen_accessors"))

module Stylet
  module Draw
    include ScreenAccessors

    attr_accessor :count, :check_fps, :sdl_event

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

      if Config[:background] && Config[:background_image]
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
      @screen.destroy
      if @backgroud_image
        @backgroud_image.destroy
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

    def draw_line(x0, y0, x1, y1, color = "white")
      @screen.draw_line(x0, y0, x1, y1, Palette[color])
    end

    def draw_rect(x, y, w, h, color = "white")
      @screen.draw_rect(x, y, w, h, Palette[color])
    end

    def fill_rect(x, y, w, h, color = "white")
      @screen.fill_rect(x, y, w, h, Palette[color])
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
