# -*- coding: utf-8 -*-
module Stylet
  module Font
    def before_main_loop
      super if defined? super
      SDL::TTF.init
      if Config[:font_name]
        font_file = Pathname(File.expand_path(File.join(File.dirname(__FILE__), "assets", Config[:font_name])))
        if font_file.exist?
          @font = SDL::TTF.open(font_file, Config[:font_size])
          logger.debug "load: #{font_file}" if logger
          if Config[:font_bold]
            @font.style = SDL::TTF::STYLE_BOLD
          end
        end
      end
    end

    def before_draw
      super if defined? super
      @gputs_ypos = 0
    end

    def after_main_loop
      super if defined? super
      if @font
        @font.close
      end
    end

    def gprint(x, y, str)
      return if (str = str.to_s) == ""
      if @font
        @font.drawBlendedUTF8(@screen, str, x, y, *Palette["font"])
      end
    end

    def gputs(str)
      return if (str = str.to_s) == ""
      gprint(0, @gputs_ypos * Config[:font_line_height], str)
      @gputs_ypos += 1
    end
  end
end
