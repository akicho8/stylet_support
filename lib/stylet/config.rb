# -*- coding: utf-8 -*-
require "active_support/configurable"

module Stylet
  module Config
    include ActiveSupport::Configurable

    config_accessor(:screen_size)      { [640, 480]       }
    config_accessor(:full_screen)      { false            }
    config_accessor(:color_depth)      { 32               }

    config_accessor(:sound_freq)       { 44100            } # SDLのデフォルトは 22050

    config_accessor(:font_name)        { "luxirr.ttf"     }
    config_accessor(:font_size)        { 18               }
    config_accessor(:font_margin)      { 3                } # 行間
    config_accessor(:font_bold)        { false            }

    config_accessor(:background)       { false            }
    config_accessor(:background_image) { "background.bmp" }
  end
end
