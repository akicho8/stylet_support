module UI
  class JoyBase
    def self.create(object)
      correspondence_table = {
        "USB Gamepad"                => "elecom_usb_pad",
        "PLAYSTATION(R)3 Controller" => "arashi",
      }
      name = SDL::Joystick.index_name(object.index).strip
      driver_name = correspondence_table[name]
      require File.expand_path(File.join(File.dirname(__FILE__), "drivers/#{driver_name}"))
      "UI::#{driver_name.classify}".constantize.new(object)
    end

    attr_reader :object

    def initialize(object)
      @object = object
    end

    def index
      @object.index
    end

    def name
      SDL::Joystick.index_name(index)
    end

    def button(n)
      @object.button(n)
    end

    def x_index
      0
    end

    def y_index
      1
    end

    def lever_on?(dir)
      case dir
      when :up
        @object.axis(y_index) == -32768
      when :down
        @object.axis(y_index) == +32767
      when :right
        @object.axis(x_index) == +32767
      when :left
        @object.axis(x_index) == -32768
      else
        false
      end
    end

    def direction
      dir = nil
      if lever_on?(:up)
        if lever_on?(:right)
          dir = 7
        elsif lever_on?(:left)
          dir = 5
        else
          dir = 6
        end
      elsif lever_on?(:down)
        if lever_on?(:right)
          dir = 1
        elsif lever_on?(:left)
          dir = 3
        else
          dir = 2
        end
      elsif lever_on?(:right)
        dir = 0
      elsif lever_on?(:left)
        dir = 4
      end
      dir
    end

    def direction2
      if dir = direction
        1.0 / 8 * dir
      end
    end

    def button_str
      (0...@object.num_buttons).collect{|index|
        if @object.button(index)
          "#{index}"
        end
      }.join
    end

    def inspect_string
      "#{@object.index}: #{name.slice(/^.{8}/)} #{inspect2}"
    end

    def inspect2
      "DIR:#{direction} BTN:#{button_str} %+04d %+04d" % [@object.axis(x_index), @object.axis(y_index)]
    end
  end
end
