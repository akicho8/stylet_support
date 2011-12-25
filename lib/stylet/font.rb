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
      @vputs_ypos = 0
    end

    def after_main_loop
      super if defined? super
      if @font
        @font.close
      end
    end

    def vprint(x, y, str)
      str = str.to_s
      return if str.empty?
      if @font
        @font.drawBlendedUTF8(@screen, str, x, y, *Palette["font"])
      end
    end

    def vputs(str)
      str = str.to_s
      return if str.empty?
      vprint(0, @vputs_ypos * (@font.line_skip + Config[:font_margin]), str)
      @vputs_ypos += 1
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../stylet"))
  Stylet::Base.main_loop do |base|
    25.times{|i|base.vputs [i, ("A".."Z").to_a.join].join(" ")}
  end
end
