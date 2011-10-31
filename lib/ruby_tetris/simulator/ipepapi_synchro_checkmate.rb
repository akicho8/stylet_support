#!/usr/local/bin/ruby -Ku


$LOAD_PATH << '..'
require "simulator"

library = [
  {
    :title => "右への赤シンクロ→全消し",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "",
    :difficulty => 4,
    :comment => "赤シンクロと橙の向きがポイント。",
    :controller => SimulateController.new,
    :pattern => "proc",
    :field => <<-EOT,
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
    :input => <<-EOT,
    Ar| d
    * r . r . Ar| d
    Ar* Cr| d
    r| d *
    EOT
  },

  {
    :title => "左への赤シンクロ→全消し",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "",
    :difficulty => 4.5,
    :comment => "青で土台を作って赤シンクロの手助け。水色の向きに注意。",
    :controller => SimulateController.new,
    :pattern => "brco",
    :field => <<-EOT,
    ......yyyy
    .....yyyyy
    ..y..yyyyy
    .yyyyyyyyy
    EOT
    :input => <<-EOT,
    A* d
    * l . l . Al| d
    Al| d
    Bl| d *
    EOT
  },

  {
    :title => "緑シンクロ→全消し",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "",
    :difficulty => 4.5,
    :comment => "赤で土台を作って緑シンクロ",
    :controller => SimulateController.new,
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
  },

  {
    :title => "シンクロ技問題",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "ogcoy",
    :field => <<-EOT,
    ......bbbb
    ......bbbb
    ....b.bbbb
    .b..bbbbbb
    EOT
  },

  {
    :title => "シンクロ技問題",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "gcoo",
    :field => <<-EOT,
    bb.....bbb
    b......bbb
    bb....bbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Br| d
    A* Cl d
    B* . B d
    * d *
    EOT
  },

  {
    :title => "シンクロ技問題",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "",
    :difficulty => 5.5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "rbcby",
    :field => <<-EOT,
    ......bbbb
    ......bbbb
    .c....bbbb
    ccc...bbbb
    EOT
  },

  {
    :title => "シンクロ技問題",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "",
    :difficulty => 6.0,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "rcgoy",
    :field => <<-EOT,
    ......bbbb
    ......bbbb
    .b....bbbb
    bb..b.bbbb
    EOT
    :input => <<-EOT,
    Al| d
    A* Cl| Bl d
    A* Cl d
    B* d
    l| d *
    EOT
  },

  {
    :title => "シンクロ技問題",
    :author => "いぺぱぴ",
    :date => "2000-02-10",
    :url => "",
    :difficulty => 6.0,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "bcoo",
    :field => <<-EOT,
    bb......gb
    bb.....ggb
    bb.b...gbb
    bbbbb.bbbb
    EOT
  },

  {
    :title => "シンクロ技問題",
    :author => "いぺぱぴ",
    :date => "2000-02-13",
    :url => "",
    :difficulty => 4.5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "obcpc",
    :field => <<-EOT,
    ........bb
    b......bbb
    b......bbb
    EOT
  },

]

if $0 == __FILE__
  Simulator.start_auto(library[2])
  exit
  
  library.each{|e| break if Simulator.start_auto(e, 60) == :break}
  exit
  if ARGV.empty?
    Simulator.start_auto(library.reverse.find{|e|!e[:input].nil?}, 60)
  else
    Simulator.start(library.reverse.find{|e|!e[:input].nil?}, 60)
  end
  Simulator.start_auto(library[0],60)
end

library
