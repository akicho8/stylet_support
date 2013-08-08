# -*- coding: utf-8 -*-
require_relative "setup"

Stylet.configure do |config|
  config.background = true
  config.background_image = "rails.png"
end

Stylet::Base.main_loop(:title => "背景にPNGを描画する例")
