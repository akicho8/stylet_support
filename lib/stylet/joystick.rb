require_relative "joystick_adapter"

module Stylet
  module Joystick
    attr_reader :joys

    def initialize
      super if defined? super
      @init_mode |= SDL::INIT_JOYSTICK
    end

    def before_main_loop
      super if defined? super
      logger.debug "SDL::Joystick.num: #{SDL::Joystick.num}" if logger
      @joys = SDL::Joystick.num.times.collect{|i|JoystickAdapter.create(SDL::Joystick.open(i))}
    end

    def polling
      super if defined? super
      SDL::Joystick.updateAll
    end

    def before_update
      super if defined? super
      @joys.each_with_index{|js_obj, index|
        vputs(js_obj.inspect_str)
      }
    end
  end
end
