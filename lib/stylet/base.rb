# -*- coding: utf-8 -*-

# gem
require 'sdl'
require 'active_support/concern'

# ruby library
require 'pp'
require 'singleton'
require 'pathname'

require 'stylet/config'

# 汎用ライブラリ
require_relative 'palette'
require_relative 'vsync_wait'
require_relative 'check_fps'
require_relative 'logger'
require_relative 'vector'
require_relative 'rect'
require_relative 'fee'
require_relative 'collision_support'
require_relative 'etc'

# 描画系
require_relative 'core'
require_relative 'callbacks'
require_relative 'pause'
require_relative 'cl_options'
require_relative 'draw'
require_relative 'font'

# 描画サポート
require_relative 'draw_support/circle'
require_relative 'draw_support/polygon'
require_relative 'draw_support/arrow'

# 入力系
require_relative 'joystick'
require_relative 'keyboard'
require_relative 'mouse'

# オーディオ系
require_relative 'audio'

module Stylet
  class Base
    include Core
    include Callbacks
    include Draw
    include DrawSupport
    include Font
    include Joystick
    include Keyboard
    include Mouse
    include Pause
    include ClOptions
  end
end

if $0 == __FILE__
  count = 0
  Stylet.run do |win|
    win.vputs(count += 1)
  end
end
