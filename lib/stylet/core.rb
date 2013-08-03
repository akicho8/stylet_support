# -*- coding: utf-8 -*-
module Stylet
  module Core
    extend ActiveSupport::Concern

    module ClassMethods
      def main_loop(*args, &block)
        instance.main_loop(*args, &block)
      end

      def app(*args, &block)
        instance.main_loop(*args){|win|win.instance_eval(&block)}
      end
    end

    def initialize
      @init_mode = 0
      @sdl_initialized = false
    end

    def logger
      Stylet.logger
    end

    def before_main_loop
      return if @sdl_initialized
      SDL.init(@init_mode)
      logger.debug "SDL.init #{'%08x' % @init_mode}" if logger
      @sdl_initialized = true
    end

    def before_update
    end

    def update
    end

    def after_update
    end

    def after_draw
    end

    def after_main_loop
    end

    def main_loop(*args, &block)
      options = {
      }.merge(args.extract_options!)
      if options[:title]
        @title = options[:title]
      end
      before_main_loop
      catch(:exit) do
        loop do
          polling
          if system_pause?
            next
          end
          before_draw
          background_clear
          before_update
          update
          if block_given?
            block.call(self)
          end
          after_update
          after_draw
        end
      end
      after_main_loop
    end
  end
end
