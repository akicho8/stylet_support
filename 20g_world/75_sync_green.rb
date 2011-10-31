# -*- coding: utf-8 -*-
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
  :field => <<-EOT,
  .....bbbbb
  o....bbbbb
  o....bbbbb
  oo...bbbbb
  EOT
  :input => <<-EOT,
  A* l d
  A* l . Al d
  Bl| . B d
  l| d *
  EOT
}

if $0 == __FILE__
  Simulator.start(Library)
end
