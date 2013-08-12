# -*- coding: utf-8 -*-
module Stylet
  module Font
    def before_run
      super if defined? super
      SDL::TTF.init
      if Stylet::Config.font_name
        font_file = Pathname("#{__dir__}/assets/#{Stylet::Config.font_name}")
        if font_file.exist?
          @font = SDL::TTF.open(font_file.to_s, Stylet::Config.font_size)
          logger.debug "load: #{font_file}" if logger
          if Stylet::Config.font_bold
            @font.style = SDL::TTF::STYLE_BOLD
          end
        end
      end
    end

    def before_draw
      super if defined? super
      @__vputs_lines = 0
    end

    def after_run
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
        vputs(str, :vector => Vector.new(0, @__vputs_lines * (@font.line_skip + Stylet::Config.font_margin)))
        @__vputs_lines += 1
      end
    end
  end
end

if $0 == __FILE__
  require_relative "../stylet"
  Stylet::Config.font_name = "VeraMono.ttf"
  Stylet::Config.font_size = 20
  Stylet.run do |win|
    25.times{|i|win.vputs [i, ("A".."Z").to_a.join].join(" ")}
  end
end
