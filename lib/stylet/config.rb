# -*- coding: utf-8 -*-

module Stylet
  unless const_defined? :Conf
    Conf = {
      # :font_name        => "FAMania2.6.otf",
      # :font_size        => 12,

      # :font_name        => "gamecuben.ttf",
      # :font_size        => 12,

      # :font_name        => "orangeki.ttf",
      # :font_size        => 20,

      # :font_name        => "flappy_for_famicom.ttf",
      # :font_size        => 16,

      :font_name        => "luxirr.ttf",
      :font_size        => 18,

      # :font_name        => "VeraMono.ttf",
      # :font_size        => 20,

      :font_margin      => 3,    # 行間
      :font_bold        => false,
      :full_screen      => false,
      :screen_size      => [640, 480],
      :background       => false,
      :background_image => "background.bmp",
      :color_depth      => 32,
      :sound_frequency  => 44100, # SDLのデフォルトは 22050

      :cry              => true,
    }
  end
end

if $0 == __FILE__
  require_relative "../stylet"
  Stylet::Base.main_loop
end
