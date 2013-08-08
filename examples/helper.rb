require_relative "setup"

module Helper
  module Cursor
    extend ActiveSupport::Concern

    include Stylet::Input::Base
    include Stylet::Input::StandardKeybord
    include Stylet::Input::JoystickBinding
    include Stylet::Input::MouseButtonAsCounter

    included do
      attr_reader :cursor
    end

    def before_main_loop
      super
      @cursor = CursorSet.new
      @cursor.point = @mouse.point.clone
    end

    def update
      super

      if joy = joys.first
        update_by_joy(joy)
      end
      key_counter_update_all

      if mouse.moved?
        @cursor.point = @mouse.point.clone
      end

      if angle = axis_angle
        @cursor.point += Stylet::Vector.angle_at(angle) * @cursor.speed
      end

      if @cursor.display
        draw_circle(@cursor.point, :radius => @cursor.radius, :vertex => @cursor.vertex, :angle => 1.0 / 64 * @count)
      end
    end

    class CursorSet
      attr_accessor :point, :speed, :vertex, :radius, :display

      def initialize
        @speed   = 5
        @vertex  = 3
        @radius  = 8
        @display = true
      end
    end
  end

  module ObjectCollection
    extend ActiveSupport::Concern

    included do
      attr_reader :objects
    end

    def before_main_loop
      super
      @objects = []
    end

    def update
      super
      @objects.each(&:update)
      @objects.reject!{|e|e.respond_to?(:screen_out?) && e.screen_out?}
    end
  end

  module CursorWithObjectCollection
    extend ActiveSupport::Concern
    include ObjectCollection
    include Cursor
  end
end

if $0 == __FILE__
  Class.new(Stylet::Base) do
    include Helper::CursorWithObjectCollection
    main_loop
  end
end
