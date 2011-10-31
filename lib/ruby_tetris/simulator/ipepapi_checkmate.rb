#!/usr/local/bin/ruby -Ku


$LOAD_PATH << '..'
require "simulator"

library = [
  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-01-23",
    :url => "",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "bobbc",
    :input => nil,
    :field => <<-EOT
    bbb.......
    bbb.......
    bbb.b.....
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-01-23",
    :url => "",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "pgbbo",
    :input => nil,
    :field => <<-EOT
    ......bbbb
    .....bbbbb
    .....bbbbb
    bb....bbbb
    EOT
  },

  {
    :title => "初手はどこだ",
    :author => "いぺぱぴ",
    :date => "2000-01-23",
    :url => "",
    :difficulty => 6,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "bcbyooc",
    :input => nil,
    :field => <<-EOT
    .........p
    bb.......p
    b.......pp
    b....p.ppp
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-01-23",
    :url => "",
    :difficulty => 6,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "roporcc",
    :input => nil,
    :field => <<-EOT
    .........b
    b.c.....bb
    bccc...bbb
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-01-23",
    :url => "",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "gocyo",
    :input => nil,
    :field => <<-EOT
    bbbbb.....
    bbbbbc....
    bbbbbcc...
    bbbbbc....
    bbbbbb....
    EOT
  },

  {
    :title => "初手がわかれば、後は。",
    :author => "いぺぱぴ",
    :date => "2000-01-18",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "rcbbgb",
    :input => nil,
    :field => <<-EOT
    b.........
    bb......b.
    bbb.......
    bbbbbb.bbb
    EOT
  },

  {
    :title => "20Gでお楽しみ下さい(^o^)",
    :author => "いぺぱぴ",
    :date => "2000-01-18",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "cobrgy",
    :input => nil,
    :field => <<-EOT
    .........b
    bp..o.....
    bpp.o....b
    bbp.oo..bb
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-01-18",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "ccrgooo",
    :input => nil,
    :field => <<-EOT
    .......b..
    b.........
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-01-09",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "ccrr",
    :input => nil,
    :field => <<-EOT
    bbbbb.....
    bbbbb..b..
    bbbbb..b..
    bbbbb..bb.
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-01-09",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "ccrr",
    :input => nil,
    :field => <<-EOT
    .....bbbbb
    ..b..bbbbb
    ..b..bbbbb
    .bb..bbbbb
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-01-09",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "ccrr",
    :input => nil,
    :field => <<-EOT
    bbbb.....b
    bbbb..b..b
    bbbb..b..b
    bbbb..bb.b
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-02-13",
    :url => "",
    :difficulty => 6,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "rogpgob",
    :input => nil,
    :field => <<-EOT
    bbbb......
    bbb.......
    bbb.......
    bbbb......
    bbbbbbb..b
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-02-13",
    :url => "",
    :difficulty => 3.5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "gbgcy",
    :input => nil,
    :field => <<-EOT
    b........b
    bb.......b
    bbbb.....b
    EOT
  },

  {
    :title => "20Gを前提とした問題",
    :author => "いぺぱぴ",
    :date => "2000-02-13",
    :url => "",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "ybgpbbo",
    :input => nil,
    :field => <<-EOT
    .......bbb
    ........bb
    b.......bb
    b......bbb
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-02-13",
    :url => "",
    :difficulty => 5.5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "bbbobc",
    :input => nil,
    :field => <<-EOT
    bbbb....bb
    bbb.....bb
    bbb......b
    bbb......b
    bbbb..b.bb
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-02-13",
    :url => "",
    :difficulty => 5.5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "cocgo",
    :input => nil,
    :field => <<-EOT
    bbbbb...bb
    bbbbb....b
    bbbb.....b
    bbbbb....b
    bbbbbb...b
    bbbbbb.bbb
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-05-16",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "bco",
    :input => nil,
    :field => <<-EOT
    ccccccc...
    cccccc....
    cccccc...c
    ccccccc..c
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-05-16",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "yobc",
    :input => nil,
    :field => <<-EOT
    ccccc.....
    ccccc.....
    cccccc...c
    cccccc...c
    EOT
  },

  {
    :title => "詰めテト",
    :author => "いぺぱぴ",
    :date => "2000-05-16",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "pygob",
    :input => nil,
    :field => <<-EOT
    cccc......
    cccc......
    ccccc.....
    cccccc...c
    EOT
  },

]

if $0 == __FILE__
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
