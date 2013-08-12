# -*- coding: utf-8 -*-
require "./setup"

Stylet::Config.configure do |config|
  config.background = true
  config.background_image = "rails.png"
end

Stylet.run(:title => "背景にPNGを描画する例")
