# -*- coding: utf-8 -*-

module Stylet
  module SystemPause
    def initialize
      super if defined? super
      @system_pause = false
      @system_pause_key ||= SDL::Key::P
    end

    def polling
      super if defined? super
      if key_down?(@system_pause_key)
        @system_pause = !@system_pause
      end
    end

    def system_pause?
      @system_pause
    end
  end
end

if $0 == __FILE__
  require File.expand_path(File.join(File.dirname(__FILE__), "../stylet"))
  Stylet::Base.main_loop
end
