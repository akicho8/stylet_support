# -*- coding: utf-8 -*-
module Stylet
  module Core
    extend ActiveSupport::Concern

    included do
      include Singleton
      cattr_accessor :_active_frame
    end

    module ClassMethods
      # run{|win| win.vputs 'Hello' }
      # run{ vputs 'Hello' }
      def run(*args, &block)
        active_frame.run(*args, &block)
      end

      def active_frame
        _active_frame || instance
      end
    end

    def initialize
      @init_code = 0
      @initialized = false
      self._active_frame = self
    end

    def logger
      Stylet.logger
    end

    def before_run
      return if @initialized
      SDL.init(@init_code)
      logger.debug "SDL.init #{'%08x' % @init_code}" if logger
      @initialized = true
    end

    def polling
    end

    def before_update
    end

    def update
    end

    def after_update
    end

    def after_draw
    end

    def after_run
    end

    def run(*args, &block)
      options = {
      }.merge(args.extract_options!)
      if options[:title]
        @title = options[:title]
      end
      before_run
      catch(:exit) do
        loop do
          polling
          if pause?
            next
          end
          before_draw
          background_clear
          before_update
          update
          if block_given?
            if block.arity == 1
              block.call(self)
            else
              instance_eval(&block)
            end
          end
          after_update
          after_draw
        end
      end
      after_run
    end
  end
end
