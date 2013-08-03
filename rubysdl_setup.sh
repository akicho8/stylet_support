#!/bin/sh
brew uninstall sdl
brew uninstall sdl_ttf
brew uninstall sdl_mixer
brew uninstall sdl_image
brew uninstall sge

brew update
brew install sdl
brew install sdl_mixer
brew install sdl_ttf
brew install sdl_image
brew install https://gist.github.com/mitmul/5410467/raw/c4fa716635e951b61f489726976b10f00dd41306/sge.rb

gem uninstall -ax rubysdl rsdl
gem install rubysdl rsdl

ruby -r sdl -e 'p [:ttf, SDL.constants.include?(:TTF)]'
ruby -r sdl -e 'p [:mixer, SDL.constants.include?(:Mixer)]'
ruby -r sdl -e 'p [:sge, SDL.respond_to?(:autoLock)]'

rsdl -r sdl -e 'SDL.init(SDL::INIT_EVERYTHING); SDL.set_video_mode(640, 480, 16, SDL::SWSURFACE); sleep(1)'
