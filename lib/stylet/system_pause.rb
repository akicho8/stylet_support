# -*- coding: utf-8 -*-

module Stylet
  module SystemPause
    def initialize
      super if defined? super
      @system_pause = false
      @system_pause_keys ||= [SDL::Key::P, SDL::Key::SPACE, SDL::Key::RETURN]
    end

    def polling
      super if defined? super
      if @system_pause_keys.any?{|key|key_down?(key)}
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
