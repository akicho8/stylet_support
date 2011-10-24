#!/usr/local/bin/ruby -Ku
# 入力をSDLに対応させる


require "ui/sdl/draw"

module SDLInput
  module JoyStickCheckMethods
    def ps3_joy_stick_read_index_of(index)
      if joy = UI::Sdl::JoyStickUtils.instance.joys[index]
        @axis.up    << joy.button(4)
        @axis.down  << joy.button(6)
        @axis.left  << joy.button(7)
        @axis.right << joy.button(5)
        @button.btA << joy.button(15)
        @button.btB << joy.button(12)
        @button.btC << joy.button(11)
        @button.btD << joy.button(10)
      end
    end
  end

  module Player1
    def update(*args)
      super
      SDL::Key.scan
      @axis.up    << SDL::Key.press?(SDL::Key::UP)
      @axis.down  << SDL::Key.press?(SDL::Key::DOWN)
      @axis.left  << SDL::Key.press?(SDL::Key::LEFT)
      @axis.right << SDL::Key.press?(SDL::Key::RIGHT)
      @button.btA << SDL::Key.press?(SDL::Key::Z)
      @button.btB << SDL::Key.press?(SDL::Key::X)
      @button.btC << SDL::Key.press?(SDL::Key::C)
      @button.btD << SDL::Key.press?(SDL::Key::V)

      # ASDFは同時押しシミューレート用
      # A:←A S:←B D:→A F:→B
      @axis.left  << (SDL::Key.press?(SDL::Key::A) | SDL::Key.press?(SDL::Key::S))
      @axis.right << (SDL::Key.press?(SDL::Key::D) | SDL::Key.press?(SDL::Key::F))
      @button.btA << (SDL::Key.press?(SDL::Key::A) | SDL::Key.press?(SDL::Key::D))
      @button.btB << (SDL::Key.press?(SDL::Key::S) | SDL::Key.press?(SDL::Key::F))

      ps3_joy_stick_read_index_of(0)
    end
  end

  module Player2
    def update(*args)
      super
      SDL::Key.scan
      @axis.up    << SDL::Key.press?(SDL::Key::K)
      @axis.down  << SDL::Key.press?(SDL::Key::J)
      @axis.left  << SDL::Key.press?(SDL::Key::H)
      @axis.right << SDL::Key.press?(SDL::Key::L)
      @button.btA << SDL::Key.press?(SDL::Key::U)
      @button.btB << SDL::Key.press?(SDL::Key::I)
      @button.btC << SDL::Key.press?(SDL::Key::O)
      @button.btD << SDL::Key.press?(SDL::Key::P)
      ps3_joy_stick_read_index_of(1)
    end
  end
end

module Players
  class Player1
    include SDLInput::JoyStickCheckMethods
    include SDLInput::Player1
  end

  class Player2
    include SDLInput::JoyStickCheckMethods
    include SDLInput::Player2
  end
end

if $0 == __FILE__
end
