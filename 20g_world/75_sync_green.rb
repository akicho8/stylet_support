#!/usr/local/bin/ruby -Ku
require "environment"

Library = {
  :title => "緑シンクロ→全消し",
  :author => "いぺぱぴ",
  :date => "2000-02-09",
  :url => "",
  :difficulty => 4.5,
  :comment => "赤で土台を作って緑シンクロ",
  :controller => SimulateWithSoundController.new,
  :pattern => "rgoy",
  :field => <<-EOS,
  .....bbbbb
  o....bbbbb
  o....bbbbb
  oo...bbbbb
  EOS
  :input => <<-EOS,
  A* l d
  A* l . Al d
  Bl| . B d
  l| d *
  EOS
}

if $0 == __FILE__
  Simulator.start(Library)
end
