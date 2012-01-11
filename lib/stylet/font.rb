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
      @__vputs_lines = 0
    end

    def after_main_loop
      super if defined? super
      if @font
        @font.close
      end
    end

    # def vprint(x, y, str)
    #   str = str.to_s
    #   return if str.empty?
    #   if @font
    #     @font.drawBlendedUTF8(@screen, str, x, y, *Palette["font"])
    #   end
    # end

    #
    # フォント表示
    #
    #   vputs "Hello"                             # 垂れ流し
    #   vputs "Hello", :vector => Vector.new(1, 2)  # 座標指定
    #
    def vputs(str, options = {})
      return unless @font
      str = str.to_s
      return if str.empty?

      if options[:vector]
        begin
          @font.drawBlendedUTF8(@screen, str, options[:vector].x, options[:vector].y, *Palette["font"])
        rescue RangeError
        end
      else
        vputs(str, :vector => Vector.new(0, @__vputs_lines * (@font.line_skip + Config[:font_margin])))
        @__vputs_lines += 1
      end
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../stylet"))
  Stylet::Config.update(:font_name => "VeraMono.ttf", :font_size => 20)
  Stylet::Base.main_loop do |win|
    25.times{|i|win.vputs [i, ("A".."Z").to_a.join].join(" ")}
  end
end
