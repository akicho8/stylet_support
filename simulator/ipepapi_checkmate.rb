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
    :field => <<-EOS
    bbb.......
    bbb.......
    bbb.b.....
    EOS
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
    :field => <<-EOS
    ......bbbb
    .....bbbbb
    .....bbbbb
    bb....bbbb
    EOS
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
    :field => <<-EOS
    .........p
    bb.......p
    b.......pp
    b....p.ppp
    EOS
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
    :field => <<-EOS
    .........b
    b.c.....bb
    bccc...bbb
    EOS
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
    :field => <<-EOS
    bbbbb.....
    bbbbbc....
    bbbbbcc...
    bbbbbc....
    bbbbbb....
    EOS
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
    :field => <<-EOS
    b.........
    bb......b.
    bbb.......
    bbbbbb.bbb
    EOS
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
    :field => <<-EOS
    .........b
    bp..o.....
    bpp.o....b
    bbp.oo..bb
    EOS
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
    :field => <<-EOS
    .......b..
    b.........
    EOS
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
    :field => <<-EOS
    bbbbb.....
    bbbbb..b..
    bbbbb..b..
    bbbbb..bb.
    EOS
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
    :field => <<-EOS
    .....bbbbb
    ..b..bbbbb
    ..b..bbbbb
    .bb..bbbbb
    EOS
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
    :field => <<-EOS
    bbbb.....b
    bbbb..b..b
    bbbb..b..b
    bbbb..bb.b
    EOS
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
    :field => <<-EOS
    bbbb......
    bbb.......
    bbb.......
    bbbb......
    bbbbbbb..b
    EOS
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
    :field => <<-EOS
    b........b
    bb.......b
    bbbb.....b
    EOS
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
    :field => <<-EOS
    .......bbb
    ........bb
    b.......bb
    b......bbb
    EOS
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
    :field => <<-EOS
    bbbb....bb
    bbb.....bb
    bbb......b
    bbb......b
    bbbb..b.bb
    EOS
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
    :field => <<-EOS
    bbbbb...bb
    bbbbb....b
    bbbb.....b
    bbbbb....b
    bbbbbb...b
    bbbbbb.bbb
    EOS
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
    :field => <<-EOS
    ccccccc...
    cccccc....
    cccccc...c
    ccccccc..c
    EOS
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
    :field => <<-EOS
    ccccc.....
    ccccc.....
    cccccc...c
    cccccc...c
    EOS
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
    :field => <<-EOS
    cccc......
    cccc......
    ccccc.....
    cccccc...c
    EOS
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
