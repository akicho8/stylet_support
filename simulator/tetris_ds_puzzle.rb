#!/usr/local/bin/ruby -Ku

# module Kernel
#   alias_method(:old_require, :require)
#   def require(*args)
#     p args
#     old_require(*args)
#   end
# end

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "simulator"

library = [
  {
    :title => "1",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgr",
    :field => <<-EOS,
    ..........
    .....bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Al| d
     l| d *
    EOS
  },
  {
    :title => "2",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcb",
    :field => <<-EOS,
    ..........
    bbbbb bbbb
    ...bb.bbbb
    ...bb.bbbb
    b.bbb.bbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    A_ d
    l| d
    l| d *
    EOS
  },
  {
    :title => "3",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yco",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb..b
    EOS
    :input => <<-EOS,
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "4",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbr",
    :field => <<-EOS,
    ..........
    b...b....b
    bbbbb...bb
    bbbbbb.bbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    r| d
    Al| B d
    r| d *
    EOS
  },
  {
    :title => "5",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rro",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbb...b
    bbbbbb.b.b
    bbbbbbbb.b
    bbbbbb.b.b
    EOS
    :input => <<-EOS,
    r| A d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "6",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cro",
    :field => <<-EOS,
    ..........
    b........b
    bbbb...bbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    l| d
    r| d *
    EOS
  },
  {
    :title => "7",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgb",
    :field => <<-EOS,
    ..........
    bbb....bbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb....bbb
    bbbbb..bbb
    EOS
    :input => <<-EOS,
    Al| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "8",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rob",
    :field => <<-EOS,
    ..........
    bb.....bbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bb.bbb
    EOS
    :input => <<-EOS,
    Al| d
    Bl| d
    r| d *
    EOS
  },
  {
    :title => "9",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "poy",
    :field => <<-EOS,
    ..........
    bb..bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    b..bbbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "10",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbo",
    :field => <<-EOS,
    ..........
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Br| d *
    EOS
  },
  {
    :title => "11",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cob",
    :field => <<-EOS,
    ..........
    ..bbbb...b
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Al| d
    Bl| d
    r| d *
    EOS
  },
  {
    :title => "12",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ory",
    :field => <<-EOS,
    ..........
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "13",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ocb",
    :field => <<-EOS,
    ..........
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbbb.bbbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| d *
    EOS
  },
  {
    :title => "14",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rrb",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb..bb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Ar| d
    r| l A d
    Ar| d *
    EOS
  },
  {
    :title => "15",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybo",
    :field => <<-EOS,
    ..........
    b...bb...b
    bbbbbb...b
    bbbbbb..bb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    r| d
    r| d
    l| d *
    EOS
  },
  {
    :title => "16",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgr",
    :field => <<-EOS,
    ..........
    bb.....bbb
    bbb...bbbb
    bbbb...bbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    _ d
    Br| d
    l| d *
    EOS
  },
  {
    :title => "17",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rob",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbb....
    bbbbbb.bbb
    bbbbbb.bbb
    bbbbbb.b.b
    EOS
    :input => <<-EOS,
    Ar| d
    Ar| C d
    r| d *
    EOS
  },
  {
    :title => "18",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rco",
    :field => <<-EOS,
    ..........
    bbbb....bb
    bbbb....bb
    bbbb...bbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    Al| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "19",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "roy",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbb....
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbb..bb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "20",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ocb",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "21",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ooc",
    :field => <<-EOS,
    ..........
    bbbb.....b
    bbbbb.bbbb
    bbbbb.....
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Br| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "22",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ppc",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    ....bbbbbb
    b..bbbbbbb
    b..bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "23",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gpb",
    :field => <<-EOS,
    ..........
    bbbb.....b
    bbbbbb...b
    bbbbbbb..b
    bbbbbb..bb
    EOS
    :input => <<-EOS,
    Br| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "24",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pyc",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "25",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bpy",
    :field => <<-EOS,
    ..........
    bbb...bbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    bbbb..bbbb
    EOS
    :input => <<-EOS,
    Al| d
    Bl| d
    _ d *
    EOS
  },
  {
    :title => "26",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obr",
    :field => <<-EOS,
    ..........
    bb.....bbb
    bb...bbbbb
    bb...bbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Al| C d
    _ d *
    EOS
  },
  {
    :title => "27",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bpr",
    :field => <<-EOS,
    ..........
    bbb.....bb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Bl| d
    r| d *
    EOS
  },
  {
    :title => "28",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bob",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbbb.bbb
    bbbbb..bbb
    EOS
    :input => <<-EOS,
    Ar| d
    Ar| C d
    Ar| d *
    EOS
  },
  {
    :title => "29",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yco",
    :field => <<-EOS,
    ..........
    bbbb......
    bbbbb...bb
    bbbbbb..bb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "30",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogb",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "31",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "occ",
    :field => <<-EOS,
    ..........
    b......bbb
    bb....bbbb
    bbb.bbbbbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    _ d
    l| d
    r| d *
    EOS
  },
  {
    :title => "32",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycy",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbb..bbbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    EOS
    :input => <<-EOS,
    _ d
    A_ d
    r| d *
    EOS
  },
  {
    :title => "33",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "roo",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbbbb.bb
    bbbbbbb.bb
    bbbbbb..bb
    bbbbbb..bb
    EOS
    :input => <<-EOS,
    Ar| d
    Ar| C d
    Br| d *
    EOS
  },
  {
    :title => "34",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ocb",
    :field => <<-EOS,
    ..........
    bbbb......
    bbbbbb...b
    bbbbbb..bb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "35",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bob",
    :field => <<-EOS,
    ..........
    bb......bb
    bb.bbbbbbb
    bb.bb...bb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Al| d
    Ar| C d
    r| d *
    EOS
  },
  {
    :title => "36",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "poy",
    :field => <<-EOS,
    ..........
    b....bbbbb
    bb...bbbbb
    bb..bbbbbb
    bb...bbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "37",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbc",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "38",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "poc",
    :field => <<-EOS,
    ..........
    bbbbb..bbb
    bbb....bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbbb.bbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    d_ *
    EOS
  },
  {
    :title => "39",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbo",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    ...bbbbbbb
    ...bbbbbbb
    b.bbbbbbbb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| . B d
    l| d *
    EOS
  },
  {
    :title => "40",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ccb",
    :field => <<-EOS,
    ..........
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb.bb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    Ar| d *
    EOS
  },
  {
    :title => "41",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bbc",
    :field => <<-EOS,
    ..........
    bbb...bbbb
    bb....bbbb
    bbbb..bbbb
    bbb..bbbbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    Al| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "42",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcy",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbbbb.
    bbbbbb....
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "43",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ygc",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    b..bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "44",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "goc",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbb....b
    bbbbb...bb
    bbbbbb..bb
    EOS
    :input => <<-EOS,
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "45",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rpo",
    :field => <<-EOS,
    ..........
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    ..bbbbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Bl| d
    Bl| d *
    EOS
  },
  {
    :title => "46",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pgc",
    :field => <<-EOS,
    ..........
    bb....bbbb
    bb....bbbb
    bb..bbbbbb
    bbb..bbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "47",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rpb",
    :field => <<-EOS,
    ..........
    .....bbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "48",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gpy",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    b..bbbbbbb
    ...bbbbbbb
    b..bbbbbbb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "49",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogy",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    EOS
    :input => <<-EOS,
    Ar_ Cr| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "50",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oco",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Bl| d
    Bl| d *
    EOS
  },
  {
    :title => "51",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cpo",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb.b.
    bbbbbbbbb.
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    Br| d *
    EOS
  },
  {
    :title => "52",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgb",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbb...bbb
    bbbbb..bbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    r| d
    Br| d
    A_ d *
    EOS
  },
  {
    :title => "53",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cpo",
    :field => <<-EOS,
    ..........
    bb...bbbbb
    bb...bbbbb
    bb...bbbbb
    bbb.bbbbbb
    bb..bbbbbb
    EOS
    :input => <<-EOS,
    l| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "54",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogb",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| d *
    EOS
  },
  {
    :title => "55",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "boc",
    :field => <<-EOS,
    ..........
    b....bbbbb
    b....bbbbb
    b...bbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    Bl| . B d
    Al| . A d
    l| d *
    EOS
  },
  {
    :title => "56",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rco",
    :field => <<-EOS,
    ..........
    b...bbbbbb
    b...bbbbbb
    bb.bbbbbbb
    b..bbbbbbb
    bb.bbbbbbb
    bb..bbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Al| d
    Bl| d *
    EOS
  },
  {
    :title => "57",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogc",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    b...bbbbbb
    b...bbbbbb
    b..bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "58",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bcb",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    A_ d
    r| d
    r| d *
    EOS
  },
  {
    :title => "59",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "opb",
    :field => <<-EOS,
    ..........
    b.....bbbb
    bb...bbbbb
    bb...bbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    l| d
    _ d
    l| d *
    EOS
  },
  {
    :title => "60",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybc",
    :field => <<-EOS,
    ..........
    bbb....bbb
    bbb...bbbb
    bbb..bbbbb
    bbb...bbbb
    EOS
    :input => <<-EOS,
    l| d
    B_ . B d
    r| d *
    EOS
  },
  {
    :title => "61",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oyc",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbb..bbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Ar| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "62",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rco",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    b.bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    b.bbbbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Al| d
    Bl| d *
    EOS
  },
  {
    :title => "63",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oob",
    :field => <<-EOS,
    ..........
    b....bbbbb
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    EOS
    :input => <<-EOS,
    l| d
    B_ . B d
    l| d *
    EOS
  },
  {
    :title => "64",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "orb",
    :field => <<-EOS,
    ..........
    bbb....bbb
    bbb..bbbbb
    bbb..b.bbb
    bbb..bbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    B_ d
    Bl| d
    r| d *
    EOS
  },
  {
    :title => "65",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yco",
    :field => <<-EOS,
    ..........
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    _ d
    Br| d
    B_ d *
    EOS
  },
  {
    :title => "66",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "opy",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb...bbb
    bbbb..bbbb
    EOS
    :input => <<-EOS,
    A_ d
    Br| d
    Br| d *
    EOS
  },
  {
    :title => "67",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbb",
    :field => <<-EOS,
    ..........
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "68",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pby",
    :field => <<-EOS,
    ..........
    bbb....bbb
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    l| d *
    EOS
  },
  {
    :title => "69",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbc",
    :field => <<-EOS,
    ..........
    bbbbb....b
    bbbbb...bb
    bbbbb...bb
    bbbbbb..bb
    EOS
    :input => <<-EOS,
    r| d
    Br| . B d
    r| d *
    EOS
  },
  {
    :title => "70",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "crb",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbb.b.bbb
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    A_ d *
    EOS
  },
  {
    :title => "71",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yob",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    r| d
    Ar| d
    Ar| d *
    EOS
  },
  {
    :title => "72",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgc",
    :field => <<-EOS,
    ..........
    bb....bbbb
    bbb...bbbb
    bbb...bbbb
    bbbbb.bbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    A_ d
    B_ A B d
    l| d *
    EOS
  },
  {
    :title => "73",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbb",
    :field => <<-EOS,
    ..........
    bbb.....bb
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    EOS
    :input => <<-EOS,
    r| d
    Ar| d
    _ d *
    EOS
  },
  {
    :title => "74",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgb",
    :field => <<-EOS,
    ..........
    bb....bbbb
    bbb...bbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    B_ d
    l| d *
    EOS
  },
  {
    :title => "75",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bro",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Br| d *
    EOS
  },
  {
    :title => "76",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ygcr",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    ....bbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    r| d
    Br| d
    r| d
    l| d *
    EOS
  },
  {
    :title => "77",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcbc",
    :field => <<-EOS,
    ..........
    bb...bbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Bl| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "78",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcgy",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    b...bbbbbb
    b...bbbbbb
    b...bbbbbb
    bb.bbbbbbb
    bb..bbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Bl| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "79",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cpry",
    :field => <<-EOS,
    ..........
    bb.bbbb...
    bbbbbbb..b
    bb.bbbb..b
    bbbbbbb..b
    bb.bbbb...
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    Al| d
    r| d *
    EOS
  },
  {
    :title => "80",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rocy",
    :field => <<-EOS,
    ..........
    b.....bbbb
    bb....bbbb
    bbbb..bbbb
    b....bbbbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Br| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "81",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgco",
    :field => <<-EOS,
    ..........
    bbbb....bb
    bbbbbb..bb
    bbbbbb..bb
    bb....b.bb
    bb.bbbb.bb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    r| d
    l| d *
    EOS
  },
  {
    :title => "82",
    :comment => "",
    :controller => FastSimulateController.new(5.0),
    :pattern => "brcb",
    :field => <<-EOS,
    ..........
    ...bb...bb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    .bbbbbb.bb
    EOS
    :input => <<-EOS,
    Bl| u d
    Al| u d
    l| u d
    * r . r u d *
    EOS
  },
  {
    :title => "83",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yycc",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    b....bbbbb
    b..bbbbbbb
    b...bbbbbb
    b..bbbbbbb
    b..bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    l| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "84",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obcr",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbbb..bb
    bbbbbb..bb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "85",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ypco",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb...b
    EOS
    :input => <<-EOS,
    r| d
    r| d
    Ar| d
    Br| d *
    EOS
  },
  {
    :title => "86",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yboo",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbb.bb.
    EOS
    :input => <<-EOS,
    r| d
    r| d
    Ar| C d
    r| d *
    EOS
  },
  {
    :title => "87",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgby",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbbb..bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbbb.bb
    ..bbb.bbbb
    ..bbbbbbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| d
    l| d *
    EOS
  },
  {
    :title => "88",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycor",
    :field => <<-EOS,
    ..........
    ....bbb...
    ...bbbb.bb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    l| d
    Br| A d
    l| d *
    EOS
  },
  {
    :title => "89",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcpc",
    :field => <<-EOS,
    ..........
    bbb....bbb
    bbb...bbbb
    bbb...bbbb
    bbb.bbbbbb
    bbb.b.bbbb
    bbb...bbbb
    EOS
    :input => <<-EOS,
    Al| d
    Br| d
    Al| d
    r| d *
    EOS
  },
  {
    :title => "90",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rrbo",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbb......b
    bbbbbb...b
    bbbbbb.b.b
    bbbbbbbb.b
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    r| A d
    Ar| d
    Ar| d
    l| d *
    EOS
  },
  {
    :title => "91",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "orob",
    :field => <<-EOS,
    ..........
    bbbbb.....
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb...
    bbbbbbbbb.
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "92",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybcr",
    :field => <<-EOS,
    ..........
    b....bbbbb
    b...bbbbbb
    b..bbbbbbb
    b.......bb
    EOS
    :input => <<-EOS,
    l| d
    Bl| . B d
    l| d
    r| d *
    EOS
  },
  {
    :title => "93",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rpgo",
    :field => <<-EOS,
    ..........
    bb.....bbb
    bbb....bbb
    bbbb...bbb
    bbbbbb.bbb
    bbbbbb.bbb
    bbbb.b.bbb
    EOS
    :input => <<-EOS,
    Br| d
    r| d
    l| d
    r| d *
    EOS
  },
  {
    :title => "94",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bcoy",
    :field => <<-EOS,
    ..........
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..b..b
    bbbb..bbbb
    bbbb.bbbbb
    bbbb.bb..b
    EOS
    :input => <<-EOS,
    Al| d
    Al| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "95",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yobc",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    ..bbbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "96",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbyc",
    :field => <<-EOS,
    ..........
    ...bbbb..b
    ...bbbbbbb
    ...bbbb..b
    b..bbbbbbb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    l| d
    r| d
    l| d *
    EOS
  },
  {
    :title => "97",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obbc",
    :field => <<-EOS,
    ..........
    bb....bbbb
    bb...bbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    bb.b.bbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Al| d
    Bl| . B d
    _ d *
    EOS
  },
  {
    :title => "98",
    :comment => "",
    :controller => FastSimulateController.new(5.0),
    :pattern => "proo",
    :field => <<-EOS,
    ..........
    bbb...b...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb.b
    bbbbbbbb..
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    r| B u d_
    Ar| u d_
    r| B u d_
    * u d_ *
    EOS
  },
  {
    :title => "99",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pbry",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbbb.b
    bbbbbbb...
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "100",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgbb",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    B_ . Br| d
    Br| d
    Ar| B d
    r| d *
    EOS
  },
  {
    :title => "101",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "copo",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbbb..bbb
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "102",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "coob",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb.b.
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Ar| d
    Ar| d
    Br| d
    Ar| d *
    EOS
  },
  {
    :title => "103",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "brob",
    :field => <<-EOS,
    ..........
    bb....bbbb
    bb...bbbbb
    bb...bbbbb
    bb....bbbb
    bbb.bbbbbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Al| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "104",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgbo",
    :field => <<-EOS,
    ..........
    bbb......b
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb.bbbbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Al| d
    Br| d
    l| d
    r| d *
    EOS
  },
  {
    :title => "105",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gcbr",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    b..bbbbbbb
    .....bbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "106",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbpo",
    :field => <<-EOS,
    ..........
    bbbb....bb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    EOS
    :input => <<-EOS,
    B_ d
    A_ d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "107",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cobr",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbb.....b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "108",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oryc",
    :field => <<-EOS,
    ..........
    bbbb....bb
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbb.b.bb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    r| d
    Ar| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "109",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogcb",
    :field => <<-EOS,
    ..........
    bb...bbbbb
    .....bbbbb
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "110",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "crbb",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb...
    bbbbbbbb.b
    bbbbbbbb..
    EOS
    :input => <<-EOS,
    Ar| d
    Ar| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "111",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oyoc",
    :field => <<-EOS,
    ..........
    bb...bbbbb
    bb...bbbbb
    bbb..bbbbb
    bb...bbbbb
    bbb..bbbbb
    bbbb.bbbbb
    bbbb.bbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    l| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "112",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cobc",
    :field => <<-EOS,
    ..........
    bbbb....bb
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    A_ d
    Br| d
    A_ C d
    r| d *
    EOS
  },
  {
    :title => "113",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pgbo",
    :field => <<-EOS,
    ..........
    bbb.....bb
    bbbb....bb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| d
    B_ d *
    EOS
  },
  {
    :title => "114",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcgc",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Al| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "115",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgby",
    :field => <<-EOS,
    ..........
    bbbb....bb
    bbbb...bbb
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    A_ d
    r| d
    Ar| d
    _ d *
    EOS
  },
  {
    :title => "116",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "grbc",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbb.bbb
    bbbbbb.b.b
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    r| B d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "117",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycgy",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbb...b
    bbbbbbb..b
    bbbbbbb..b
    EOS
    :input => <<-EOS,
    r| d
    Br| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "118",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obpc",
    :field => <<-EOS,
    ..........
    bbbb.....b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbb..bbb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "119",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yccb",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbbb..
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb..b
    EOS
    :input => <<-EOS,
    r| d
    Ar| d
    Br| d
    Ar| d *
    EOS
  },
  {
    :title => "120",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bcbb",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb.bb
    bbbbbbbbb.
    EOS
    :input => <<-EOS,
    Ar| d
    Ar| d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "121",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bboc",
    :field => <<-EOS,
    ..........
    ......bbbb
    ....bbbbbb
    b...bbbbbb
    bb..bbbbbb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    l| d
    _ d
    l| d *
    EOS
  },
  {
    :title => "122",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gocr",
    :field => <<-EOS,
    ..........
    bbbb.....b
    bbbbb....b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "123",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcgb",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Br| d
    Ar| d *
    EOS
  },
  {
    :title => "124",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "coco",
    :field => <<-EOS,
    ..........
    b...bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    b...bbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Bl| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "125",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cboo",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbbbbb.
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "126",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ryco",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb.b
    bbbbbbbb.b
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Br| d
    r| d
    Ar| d
    Br| d *
    EOS
  },
  {
    :title => "127",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ocoy",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb.b.
    EOS
    :input => <<-EOS,
    Br| d
    r| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "128",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pbgc",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbb....
    bbbbbb...b
    bbbbbbb..b
    bbbbbb.b.b
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "129",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbpr",
    :field => <<-EOS,
    ..........
    bbbbb.....
    bbbbb...bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb...bb
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "130",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rycb",
    :field => <<-EOS,
    ..........
    bbb...bbbb
    bbb...bbbb
    bbb..bbbbb
    bbb...bbbb
    bbbb.bbbbb
    bbbb.bbbbb
    bbbb.bbbbb
    bbbb.bbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    l| d
    Br| d
    Al| d *
    EOS
  },
  {
    :title => "131",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obcr",
    :field => <<-EOS,
    ..........
    b.......bb
    bbb....bbb
    bbbbbb.bbb
    bbb.bb.bbb
    bbb.bb.bbb
    EOS
    :input => <<-EOS,
    Br| d
    Al| d
    r| d
    l| d *
    EOS
  },
  {
    :title => "132",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybgo",
    :field => <<-EOS,
    ..........
    bb....bbbb
    bbb...bbbb
    bbb...bbbb
    bbb..bbbbb
    bbb..bbbbb
    bb.b.bbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| . B d
    B_ d
    l| d *
    EOS
  },
  {
    :title => "133",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcrb",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbbb..b
    bbbbbb...b
    bbbbbbb..b
    bbbbbbbb.b
    bbbbbb..bb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| d
    Ar| d *
    EOS
  },
  {
    :title => "134",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cobo",
    :field => <<-EOS,
    ..........
    bbbbb....b
    bbbbb...bb
    bbbbb....b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    Ar| d
    Br| d *
    EOS
  },
  {
    :title => "135",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgyo",
    :field => <<-EOS,
    ..........
    bb.....bbb
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Bl| d
    l| d
    r| d *
    EOS
  },
  {
    :title => "136",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gboc",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb.bbbb
    bbbbb.bbbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "137",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "grbc",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ...bbbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Al| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "138",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "roby",
    :field => <<-EOS,
    ..........
    bbbbb....b
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "139",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pbor",
    :field => <<-EOS,
    ..........
    bb......bb
    bbb...bbbb
    bbb...bbbb
    bbb...bbbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    d_
    Bl| d
    r| d *
    EOS
  },
  {
    :title => "140",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcbo",
    :field => <<-EOS,
    ..........
    ...bbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbbb.
    .bbbbbbbbb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Ar| d
    l| d *
    EOS
  },
  {
    :title => "141",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cogy",
    :field => <<-EOS,
    ..........
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    bbb..bbbbb
    EOS
    :input => <<-EOS,
    A_ d
    Br| d
    B_ d
    l| d *
    EOS
  },
  {
    :title => "142",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgbc",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbbb.bbb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "143",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "coby",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    ..bbbbb..b
    bbbbbbb..b
    bbbbbbb.bb
    ..bbbbbbbb
    EOS
    :input => <<-EOS,
    Ar| d
    Ar| d
    Ar| d
    l| d *
    EOS
  },
  {
    :title => "144",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yrgo",
    :field => <<-EOS,
    ..........
    bb....bbbb
    bb...bbbbb
    bb...bbbbb
    bbb..bbbbb
    bb...bbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Al| d
    Bl| d
    d_ *
    EOS
  },
  {
    :title => "145",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbbc",
    :field => <<-EOS,
    ..........
    bbbbb.....
    bbbbbbb...
    bbbbbbbb..
    bbbbbb.b..
    bbbbbbbb..
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Br| d
    r| d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "146",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "robc",
    :field => <<-EOS,
    ..........
    .....bbbbb
    b...bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Bl| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "147",
    :comment => "青の渡し",
    :controller => FastSimulateController.new,
    :pattern => "crbo",
    :field => <<-EOS,
    ..........
    bbbb.....b
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbbb..bb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    B_ . Br| . Bl d
    Br| d *
    EOS
  },
  {
    :title => "148",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ggcb",
    :field => <<-EOS,
    ..........
    bbbb....bb
    bbbb...bbb
    bbbbb..bbb
    bbbb...bbb
    bbbbb..bbb
    bbbbb.b.bb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    A_ d
    r| d *
    EOS
  },
  {
    :title => "149",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcbb",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbbb.bbb
    bbbbbb..bb
    bbbbb..bbb
    bbbbbb.bbb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "150",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pobc",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbb....bb
    bbbbb...bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    r| d
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "151",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogpb",
    :field => <<-EOS,
    ..........
    b....bbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb.b.bbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Al| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "152",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oybc",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb...
    bbbbbbb..b
    bbbbbbbb.b
    bbbbbbbb.b
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Br| d
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "153",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gcpy",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb...bbb
    EOS
    :input => <<-EOS,
    B_ d
    A_ d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "154",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycbr",
    :field => <<-EOS,
    ..........
    b.....bbbb
    b...bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    l| d
    Bl| . B d
    l| d *
    EOS
  },
  {
    :title => "155",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bbco",
    :field => <<-EOS,
    ..........
    b....bbbbb
    b...bbbbbb
    b...bbbbbb
    b...bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "156",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cybo",
    :field => <<-EOS,
    ..........
    bbbb......
    bbbbbb...b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Ar| d
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "157",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "opbc",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbbb....b
    bbbbbb...b
    bbbbbbb..b
    bbbbbb...b
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Br| d
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "158",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pogc",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbbb.b
    bbbbbbb..b
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "159",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycbo",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbb...bbb
    bbbbb..bbb
    EOS
    :input => <<-EOS,
    r| d
    Br| d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "160",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgbo",
    :field => <<-EOS,
    ..........
    bb.....bbb
    bbb...bbbb
    bbb...bbbb
    bbb..bbbbb
    bb..b.bbbb
    EOS
    :input => <<-EOS,
    Al| d
    d_
    Ar| d
    l| d *
    EOS
  },
  {
    :title => "161",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "poco",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb.b
    bbbbbbbb..
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "162",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgco",
    :field => <<-EOS,
    ..........
    bb....bbbb
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    bb.bbbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Bl| d
    Al| d
    d_ *
    EOS
  },
  {
    :title => "163",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cpco",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "164",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yobb",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    ...bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    .bbbbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Al| d
    Al| d
    Al| d *
    EOS
  },
  {
    :title => "165",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "prcb",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Br| d
    Ar| d *
    EOS
  },
  {
    :title => "166",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pooc",
    :field => <<-EOS,
    ..........
    bbbb....bb
    bbbbb...bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb...bb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Ar| . A d
    r| d *
    EOS
  },
  {
    :title => "167",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bpcb",
    :field => <<-EOS,
    ..........
    bbb....bbb
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    A_ d
    Br| d
    Br| d
    d_ *
    EOS
  },
  {
    :title => "168",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcyc",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Al| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "169",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "crpo",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbbb.b..
    bbbbbbbbb.
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Br| d
    Br| d *
    EOS
  },
  {
    :title => "170",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cogr",
    :field => <<-EOS,
    ..........
    bbbb.....b
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbbb.bb
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    r| d
    r| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "171",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbpr",
    :field => <<-EOS,
    ..........
    bbb.....bb
    bbb....bbb
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    EOS
    :input => <<-EOS,
    d_
    Ar| d
    B_ d
    r| d *
    EOS
  },
  {
    :title => "172",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcgb",
    :field => <<-EOS,
    ..........
    bbbbb....b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb.bbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "173",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cobb",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbb....bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb..bb
    EOS
    :input => <<-EOS,
    Ar| d
    Br| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "174",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcbc",
    :field => <<-EOS,
    ..........
    bbb...bbbb
    bbb...bbbb
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbb...bbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Al| d
    d_ *
    EOS
  },
  {
    :title => "175",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycbb",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b..bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Al| d
    Al| d
    l| d *
    EOS
  },
  {
    :title => "176",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbro",
    :field => <<-EOS,
    ..........
    bbbbb....b
    bbbbbb...b
    bbbbb....b
    bbbbbb...b
    bbbbbbb.bb
    bbbbbbbb.b
    EOS
    :input => <<-EOS,
    Ar| d
    Ar| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "177",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "brcb",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    b.bbbbbbbb
    b.bbbbbbbb
    b..bbbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Al| d
    Bl| d
    Al| d *
    EOS
  },
  {
    :title => "178",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "orcb",
    :field => <<-EOS,
    ..........
    bbb...bbbb
    bbb...bbbb
    bbb...bbbb
    bbbb..bbbb
    bbbbb.bbbb
    bbb...bbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Br| d
    Al| d
    A_ d
    d_ *
    EOS
  },
  {
    :title => "179",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "opcy",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    EOS
    :input => <<-EOS,
    r| d
    Br| d
    Br| d
    d_ *
    EOS
  },
  {
    :title => "180",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcoy",
    :field => <<-EOS,
    ..........
    bbbb....bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb.bbbb
    bbbbb.bbbb
    bbbbb..bbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    Br| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "181",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "grcb",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    Al| d
    Al| d *
    EOS
  },
  {
    :title => "182",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybpc",
    :field => <<-EOS,
    ..........
    b...bbbbbb
    b...bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    Bl| d
    Bl| d
    l| d *
    EOS
  },
  {
    :title => "183",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybgo",
    :field => <<-EOS,
    ..........
    .....bbbbb
    b...bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOS
    :input => <<-EOS,
    l| d
    l| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "184",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gpbc",
    :field => <<-EOS,
    ..........
    bb...bbbbb
    b....bbbbb
    bb...bbbbb
    bb...bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    l| d
    l| d
    l| d *
    EOS
  },
  {
    :title => "185",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pbgo",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbb.b.b
    EOS
    :input => <<-EOS,
    Br| d
    Br| . B d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "186",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybpoc",
    :field => <<-EOS,
    ..........
    bbbbbb...b
    bb...b...b
    bbbbbb...b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbb.bbbb.b
    EOS
    :input => <<-EOS,
    r| d
    r| d
    Br| d
    Br| d
    l| d *
    EOS
  },
  {
    :title => "187",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bpcor",
    :field => <<-EOS,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    .b.b....bb
    .bbbbbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    l| d
    Al| d
    Bl| d
    r| d *
    EOS
  },
  {
    :title => "188",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rbbco",
    :field => <<-EOS,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbbb.b
    bbbbbbb...
    bbbbbbbb.b
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Ar| C d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "189",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gcpbc",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Br| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "190",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgbor",
    :field => <<-EOS,
    ..........
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    b......bbb
    EOS
    :input => <<-EOS,
    Bl| d
    Bl| d
    Al| d
    l| d
    d_ *
    EOS
  },
  {
    :title => "191",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbcbo",
    :field => <<-EOS,
    ..........
    bbbbb...bb
    bbbb....bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbb...bbb
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "192",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "boycr",
    :field => <<-EOS,
    ..........
    bbbbb.....
    bbbbb....b
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbbbb.b
    bbbbb.bbbb
    EOS
    :input => <<-EOS,
    r| d
    r| d
    r| d
    Ar| d
    r| d *
    EOS
  },
  {
    :title => "193",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bycgo",
    :field => <<-EOS,
    ..........
    bbbbb....b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Ar| d
    r| d
    Ar| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "194",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yycgb",
    :field => <<-EOS,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbbb..bbb
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    r| d
    r| d
    Br| d
    Br| d
    A_ d *
    EOS
  },
  {
    :title => "195",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbcor",
    :field => <<-EOS,
    ..........
    bbbb......
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb.b
    bbbbbbbbb.
    EOS
    :input => <<-EOS,
    r| d
    Ar| . A d
    r| d
    Br| d
    r| d *
    EOS
  },
  {
    :title => "196",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bopcr",
    :field => <<-EOS,
    ..........
    bbb.....bb
    bbb....bbb
    bbbb...bbb
    bbbb...bbb
    bbb....bbb
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    r| d
    A_ C d
    r| d
    Al| d
    r| d *
    EOS
  },
  {
    :title => "197",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bcrpo",
    :field => <<-EOS,
    ..........
    ....bbbbbb
    b...bbbbbb
    b...bbbbbb
    bb..bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    bb.bbbbbbb
    bbb.bbbbbb
    EOS
    :input => <<-EOS,
    Al| d
    Al| d
    Al| d
    l| d
    Bl| d *
    EOS
  },
  {
    :title => "198",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "propc",
    :field => <<-EOS,
    ..........
    bb.....bbb
    bb....bbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbbb.bbbbb
    EOS
    :input => <<-EOS,
    Bl| d
    Bl| d
    Bl| d
    r| d
    l| d *
    EOS
  },
  {
    :title => "199",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgccy",
    :field => <<-EOS,
    ..........
    bbbb.....b
    bbbbb....b
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb...b
    bbbbbb.bbb
    EOS
    :input => <<-EOS,
    Ar| d
    r| d
    r| d
    r| d
    r| d *
    EOS
  },
  {
    :title => "200",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gocgb",
    :field => <<-EOS,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb.bb
    EOS
    :input => <<-EOS,
    Br| d
    Ar| d
    Br| d
    Br| d
    Ar| d *
    EOS
  },
]

if $0 == __FILE__
  # Simulator.start_auto(library[199], 60)
  # Simulator.start_auto(library[199], 60)
  # exit

  # Simulator.start(library[8], 60)
  # exit

  g = UI::Sdl::Draw.instance
  catch(:exit){
    loop do
      g.polling
      g.draw_begin
      g.bg_clear
      # g.count += 1
      # g.gprint(0, 0, g.system_line)
      g.draw_end
    end
  }
  g.close

  library.each{|e| break if Simulator.start_auto(e, 30) == :break} # 13
  exit
  if ARGV.empty?
    Simulator.start_auto(library.reverse.find{|e|!e[:input].nil?}, 0)
  else
    Simulator.start(library.reverse.find{|e|!e[:input].nil?}, 0)
  end
  # Simulator.start_auto(library[0],60)
end

library
