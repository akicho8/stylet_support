require_relative "joystick_adapter"

module Stylet
  module Joystick
    attr_reader :joys

    def initialize
      super
      @init_mode |= SDL::INIT_JOYSTICK
    end

    def before_main_loop
      super
      logger.debug "SDL::Joystick.num: #{SDL::Joystick.num}" if logger
      @joys = SDL::Joystick.num.times.collect{|i|JoystickAdapter.create(SDL::Joystick.open(i))}
    end

    def polling
      super
      SDL::Joystick.updateAll
    end

    def before_update
      super
      @joys.each{|joy|vputs(joy.inspect)}
    end
  end
end
