# -*- coding: utf-8 -*-
#
# ボタンのアサイン
#
module Stylet
  module Input
    module StandardKeybord
      def update
        super if defined? super
        @axis.up    << SDL::Key.press?(SDL::Key::UP)
        @axis.down  << SDL::Key.press?(SDL::Key::DOWN)
        @axis.left  << SDL::Key.press?(SDL::Key::LEFT)
        @axis.right << SDL::Key.press?(SDL::Key::RIGHT)
        @button.btA << SDL::Key.press?(SDL::Key::Z)
        @button.btB << SDL::Key.press?(SDL::Key::X)
        @button.btC << SDL::Key.press?(SDL::Key::C)
        @button.btD << SDL::Key.press?(SDL::Key::V)
      end
    end

    module MouseButtonAsCounter
      def update
        super if defined? super
        @button.btA << @mouse.button.a
        @button.btB << @mouse.button.b
        @button.btC << @mouse.button.c
      end
    end

    module ViLikeKeyboard
      def update
        super if defined? super
        @axis.up    << SDL::Key.press?(SDL::Key::K)
        @axis.down  << SDL::Key.press?(SDL::Key::J)
        @axis.left  << SDL::Key.press?(SDL::Key::H)
        @axis.right << SDL::Key.press?(SDL::Key::L)
        @button.btA << SDL::Key.press?(SDL::Key::U)
        @button.btB << SDL::Key.press?(SDL::Key::I)
        @button.btC << SDL::Key.press?(SDL::Key::O)
        @button.btD << SDL::Key.press?(SDL::Key::P)
      end
    end

    module JoystickBinding
      def update_by_joy(joy)
        @axis.up    << joy.lever_on?(:up)
        @axis.down  << joy.lever_on?(:down)
        @axis.left  << joy.lever_on?(:left)
        @axis.right << joy.lever_on?(:right)
        @button.btA << joy.button_on?(:btA)
        @button.btB << joy.button_on?(:btB)
        @button.btC << joy.button_on?(:btC)
        @button.btD << joy.button_on?(:btD)
      end
    end
  end
end
