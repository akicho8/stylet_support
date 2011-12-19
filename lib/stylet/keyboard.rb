module Stylet
  module Keyboard
    def polling
      super if defined? super
      SDL::Key.scan
    end
  end
end
