# -*- coding: utf-8 -*-
#
# ニコニコ動画アップ用
#

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "simulator"

library = [
  {
    :title => "1",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgr",
    :field => <<-EOT,
    ..........
    .....bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Al| d
     l| d *
    EOT
  },
  {
    :title => "2",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcb",
    :field => <<-EOT,
    ..........
    bbbbb bbbb
    ...bb.bbbb
    ...bb.bbbb
    b.bbb.bbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    A_ d
    l| d
    l| d *
    EOT
  },
  {
    :title => "3",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yco",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb..b
    EOT
    :input => <<-EOT,
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "4",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbr",
    :field => <<-EOT,
    ..........
    b...b....b
    bbbbb...bb
    bbbbbb.bbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    r| d
    Al| B d
    r| d *
    EOT
  },
  {
    :title => "5",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rro",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbb...b
    bbbbbb.b.b
    bbbbbbbb.b
    bbbbbb.b.b
    EOT
    :input => <<-EOT,
    r| A d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "6",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cro",
    :field => <<-EOT,
    ..........
    b........b
    bbbb...bbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    l| d
    r| d *
    EOT
  },
  {
    :title => "7",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgb",
    :field => <<-EOT,
    ..........
    bbb....bbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb....bbb
    bbbbb..bbb
    EOT
    :input => <<-EOT,
    Al| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "8",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rob",
    :field => <<-EOT,
    ..........
    bb.....bbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bb.bbb
    EOT
    :input => <<-EOT,
    Al| d
    Bl| d
    r| d *
    EOT
  },
  {
    :title => "9",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "poy",
    :field => <<-EOT,
    ..........
    bb..bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    b..bbbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "10",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbo",
    :field => <<-EOT,
    ..........
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Br| d *
    EOT
  },
  {
    :title => "11",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cob",
    :field => <<-EOT,
    ..........
    ..bbbb...b
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Al| d
    Bl| d
    r| d *
    EOT
  },
  {
    :title => "12",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ory",
    :field => <<-EOT,
    ..........
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "13",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ocb",
    :field => <<-EOT,
    ..........
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbbb.bbbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| d *
    EOT
  },
  {
    :title => "14",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rrb",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb..bb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Ar| d
    r| l A d
    Ar| d *
    EOT
  },
  {
    :title => "15",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybo",
    :field => <<-EOT,
    ..........
    b...bb...b
    bbbbbb...b
    bbbbbb..bb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    r| d
    r| d
    l| d *
    EOT
  },
  {
    :title => "16",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgr",
    :field => <<-EOT,
    ..........
    bb.....bbb
    bbb...bbbb
    bbbb...bbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    _ d
    Br| d
    l| d *
    EOT
  },
  {
    :title => "17",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rob",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbb....
    bbbbbb.bbb
    bbbbbb.bbb
    bbbbbb.b.b
    EOT
    :input => <<-EOT,
    Ar| d
    Ar| C d
    r| d *
    EOT
  },
  {
    :title => "18",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rco",
    :field => <<-EOT,
    ..........
    bbbb....bb
    bbbb....bb
    bbbb...bbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    Al| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "19",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "roy",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbb....
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbb..bb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "20",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ocb",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "21",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ooc",
    :field => <<-EOT,
    ..........
    bbbb.....b
    bbbbb.bbbb
    bbbbb.....
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Br| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "22",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ppc",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    ....bbbbbb
    b..bbbbbbb
    b..bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "23",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gpb",
    :field => <<-EOT,
    ..........
    bbbb.....b
    bbbbbb...b
    bbbbbbb..b
    bbbbbb..bb
    EOT
    :input => <<-EOT,
    Br| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "24",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pyc",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "25",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bpy",
    :field => <<-EOT,
    ..........
    bbb...bbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    bbbb..bbbb
    EOT
    :input => <<-EOT,
    Al| d
    Bl| d
    _ d *
    EOT
  },
  {
    :title => "26",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obr",
    :field => <<-EOT,
    ..........
    bb.....bbb
    bb...bbbbb
    bb...bbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Al| C d
    _ d *
    EOT
  },
  {
    :title => "27",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bpr",
    :field => <<-EOT,
    ..........
    bbb.....bb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Bl| d
    r| d *
    EOT
  },
  {
    :title => "28",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bob",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbbb.bbb
    bbbbb..bbb
    EOT
    :input => <<-EOT,
    Ar| d
    Ar| C d
    Ar| d *
    EOT
  },
  {
    :title => "29",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yco",
    :field => <<-EOT,
    ..........
    bbbb......
    bbbbb...bb
    bbbbbb..bb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "30",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogb",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "31",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "occ",
    :field => <<-EOT,
    ..........
    b......bbb
    bb....bbbb
    bbb.bbbbbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    _ d
    l| d
    r| d *
    EOT
  },
  {
    :title => "32",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycy",
    :field => <<-EOT,
    ..........
    bbbb...bbb
    bbbb..bbbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    EOT
    :input => <<-EOT,
    _ d
    A_ d
    r| d *
    EOT
  },
  {
    :title => "33",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "roo",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbbbb.bb
    bbbbbbb.bb
    bbbbbb..bb
    bbbbbb..bb
    EOT
    :input => <<-EOT,
    Ar| d
    Ar| C d
    Br| d *
    EOT
  },
  {
    :title => "34",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ocb",
    :field => <<-EOT,
    ..........
    bbbb......
    bbbbbb...b
    bbbbbb..bb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "35",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bob",
    :field => <<-EOT,
    ..........
    bb......bb
    bb.bbbbbbb
    bb.bb...bb
    bbbbbb.bbb
    EOT
    :input => <<-EOT,
    Al| d
    Ar| C d
    r| d *
    EOT
  },
  {
    :title => "36",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "poy",
    :field => <<-EOT,
    ..........
    b....bbbbb
    bb...bbbbb
    bb..bbbbbb
    bb...bbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "37",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbc",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "38",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "poc",
    :field => <<-EOT,
    ..........
    bbbbb..bbb
    bbb....bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbbb.bbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    d_ *
    EOT
  },
  {
    :title => "39",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbo",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    ...bbbbbbb
    ...bbbbbbb
    b.bbbbbbbb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| . B d
    l| d *
    EOT
  },
  {
    :title => "40",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ccb",
    :field => <<-EOT,
    ..........
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb.bb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    Ar| d *
    EOT
  },
  {
    :title => "41",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bbc",
    :field => <<-EOT,
    ..........
    bbb...bbbb
    bb....bbbb
    bbbb..bbbb
    bbb..bbbbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    Al| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "42",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcy",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbbbb.
    bbbbbb....
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "43",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ygc",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    b..bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "44",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "goc",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbb....b
    bbbbb...bb
    bbbbbb..bb
    EOT
    :input => <<-EOT,
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "45",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rpo",
    :field => <<-EOT,
    ..........
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    ..bbbbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Bl| d
    Bl| d *
    EOT
  },
  {
    :title => "46",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pgc",
    :field => <<-EOT,
    ..........
    bb....bbbb
    bb....bbbb
    bb..bbbbbb
    bbb..bbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "47",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rpb",
    :field => <<-EOT,
    ..........
    .....bbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "48",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gpy",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    b..bbbbbbb
    ...bbbbbbb
    b..bbbbbbb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "49",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogy",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    EOT
    :input => <<-EOT,
    Ar_ Cr| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "50",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oco",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Bl| d
    Bl| d *
    EOT
  },
  {
    :title => "51",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cpo",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb.b.
    bbbbbbbbb.
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    Br| d *
    EOT
  },
  {
    :title => "52",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgb",
    :field => <<-EOT,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbb...bbb
    bbbbb..bbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    r| d
    Br| d
    A_ d *
    EOT
  },
  {
    :title => "53",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cpo",
    :field => <<-EOT,
    ..........
    bb...bbbbb
    bb...bbbbb
    bb...bbbbb
    bbb.bbbbbb
    bb..bbbbbb
    EOT
    :input => <<-EOT,
    l| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "54",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogb",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| d *
    EOT
  },
  {
    :title => "55",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "boc",
    :field => <<-EOT,
    ..........
    b....bbbbb
    b....bbbbb
    b...bbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    Bl| . B d
    Al| . A d
    l| d *
    EOT
  },
  {
    :title => "56",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rco",
    :field => <<-EOT,
    ..........
    b...bbbbbb
    b...bbbbbb
    bb.bbbbbbb
    b..bbbbbbb
    bb.bbbbbbb
    bb..bbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Al| d
    Bl| d *
    EOT
  },
  {
    :title => "57",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogc",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    b...bbbbbb
    b...bbbbbb
    b..bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "58",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bcb",
    :field => <<-EOT,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    bbbbbb.bbb
    EOT
    :input => <<-EOT,
    A_ d
    r| d
    r| d *
    EOT
  },
  {
    :title => "59",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "opb",
    :field => <<-EOT,
    ..........
    b.....bbbb
    bb...bbbbb
    bb...bbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    l| d
    _ d
    l| d *
    EOT
  },
  {
    :title => "60",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybc",
    :field => <<-EOT,
    ..........
    bbb....bbb
    bbb...bbbb
    bbb..bbbbb
    bbb...bbbb
    EOT
    :input => <<-EOT,
    l| d
    B_ . B d
    r| d *
    EOT
  },
  {
    :title => "61",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oyc",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbb..bbb
    bbbbbb.bbb
    EOT
    :input => <<-EOT,
    Ar| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "62",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rco",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    b.bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    b.bbbbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Al| d
    Bl| d *
    EOT
  },
  {
    :title => "63",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oob",
    :field => <<-EOT,
    ..........
    b....bbbbb
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    EOT
    :input => <<-EOT,
    l| d
    B_ . B d
    l| d *
    EOT
  },
  {
    :title => "64",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "orb",
    :field => <<-EOT,
    ..........
    bbb....bbb
    bbb..bbbbb
    bbb..b.bbb
    bbb..bbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    B_ d
    Bl| d
    r| d *
    EOT
  },
  {
    :title => "65",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yco",
    :field => <<-EOT,
    ..........
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    _ d
    Br| d
    B_ d *
    EOT
  },
  {
    :title => "66",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "opy",
    :field => <<-EOT,
    ..........
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb...bbb
    bbbb..bbbb
    EOT
    :input => <<-EOT,
    A_ d
    Br| d
    Br| d *
    EOT
  },
  {
    :title => "67",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbb",
    :field => <<-EOT,
    ..........
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "68",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pby",
    :field => <<-EOT,
    ..........
    bbb....bbb
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    l| d *
    EOT
  },
  {
    :title => "69",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbc",
    :field => <<-EOT,
    ..........
    bbbbb....b
    bbbbb...bb
    bbbbb...bb
    bbbbbb..bb
    EOT
    :input => <<-EOT,
    r| d
    Br| . B d
    r| d *
    EOT
  },
  {
    :title => "70",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "crb",
    :field => <<-EOT,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbb.b.bbb
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    A_ d *
    EOT
  },
  {
    :title => "71",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yob",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    r| d
    Ar| d
    Ar| d *
    EOT
  },
  {
    :title => "72",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgc",
    :field => <<-EOT,
    ..........
    bb....bbbb
    bbb...bbbb
    bbb...bbbb
    bbbbb.bbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    A_ d
    B_ A B d
    l| d *
    EOT
  },
  {
    :title => "73",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbb",
    :field => <<-EOT,
    ..........
    bbb.....bb
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    EOT
    :input => <<-EOT,
    r| d
    Ar| d
    _ d *
    EOT
  },
  {
    :title => "74",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgb",
    :field => <<-EOT,
    ..........
    bb....bbbb
    bbb...bbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    B_ d
    l| d *
    EOT
  },
  {
    :title => "75",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bro",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Br| d *
    EOT
  },
  {
    :title => "76",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ygcr",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    ....bbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    r| d
    Br| d
    r| d
    l| d *
    EOT
  },
  {
    :title => "77",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcbc",
    :field => <<-EOT,
    ..........
    bb...bbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Bl| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "78",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcgy",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    b...bbbbbb
    b...bbbbbb
    b...bbbbbb
    bb.bbbbbbb
    bb..bbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Bl| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "79",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cpry",
    :field => <<-EOT,
    ..........
    bb.bbbb...
    bbbbbbb..b
    bb.bbbb..b
    bbbbbbb..b
    bb.bbbb...
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    Al| d
    r| d *
    EOT
  },
  {
    :title => "80",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rocy",
    :field => <<-EOT,
    ..........
    b.....bbbb
    bb....bbbb
    bbbb..bbbb
    b....bbbbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Br| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "81",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgco",
    :field => <<-EOT,
    ..........
    bbbb....bb
    bbbbbb..bb
    bbbbbb..bb
    bb....b.bb
    bb.bbbb.bb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    r| d
    l| d *
    EOT
  },
  {
    :title => "82",
    :comment => "",
    :controller => FastSimulateController.new(5.0),
    :pattern => "brcb",
    :field => <<-EOT,
    ..........
    ...bb...bb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    .bbbbbb.bb
    EOT
    :input => <<-EOT,
    Bl| u d
    Al| u d
    l| u d
    * r . r u d *
    EOT
  },
  {
    :title => "83",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yycc",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    b....bbbbb
    b..bbbbbbb
    b...bbbbbb
    b..bbbbbbb
    b..bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    l| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "84",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obcr",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbbb..bb
    bbbbbb..bb
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "85",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ypco",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb...b
    EOT
    :input => <<-EOT,
    r| d
    r| d
    Ar| d
    Br| d *
    EOT
  },
  {
    :title => "86",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yboo",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbb.bb.
    EOT
    :input => <<-EOT,
    r| d
    r| d
    Ar| C d
    r| d *
    EOT
  },
  {
    :title => "87",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgby",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbbb..bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbbb.bb
    ..bbb.bbbb
    ..bbbbbbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| d
    l| d *
    EOT
  },
  {
    :title => "88",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycor",
    :field => <<-EOT,
    ..........
    ....bbb...
    ...bbbb.bb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    l| d
    Br| A d
    l| d *
    EOT
  },
  {
    :title => "89",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcpc",
    :field => <<-EOT,
    ..........
    bbb....bbb
    bbb...bbbb
    bbb...bbbb
    bbb.bbbbbb
    bbb.b.bbbb
    bbb...bbbb
    EOT
    :input => <<-EOT,
    Al| d
    Br| d
    Al| d
    r| d *
    EOT
  },
  {
    :title => "90",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rrbo",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbb......b
    bbbbbb...b
    bbbbbb.b.b
    bbbbbbbb.b
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    r| A d
    Ar| d
    Ar| d
    l| d *
    EOT
  },
  {
    :title => "91",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "orob",
    :field => <<-EOT,
    ..........
    bbbbb.....
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb...
    bbbbbbbbb.
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "92",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybcr",
    :field => <<-EOT,
    ..........
    b....bbbbb
    b...bbbbbb
    b..bbbbbbb
    b.......bb
    EOT
    :input => <<-EOT,
    l| d
    Bl| . B d
    l| d
    r| d *
    EOT
  },
  {
    :title => "93",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rpgo",
    :field => <<-EOT,
    ..........
    bb.....bbb
    bbb....bbb
    bbbb...bbb
    bbbbbb.bbb
    bbbbbb.bbb
    bbbb.b.bbb
    EOT
    :input => <<-EOT,
    Br| d
    r| d
    l| d
    r| d *
    EOT
  },
  {
    :title => "94",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bcoy",
    :field => <<-EOT,
    ..........
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..b..b
    bbbb..bbbb
    bbbb.bbbbb
    bbbb.bb..b
    EOT
    :input => <<-EOT,
    Al| d
    Al| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "95",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yobc",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    ..bbbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "96",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbyc",
    :field => <<-EOT,
    ..........
    ...bbbb..b
    ...bbbbbbb
    ...bbbb..b
    b..bbbbbbb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    l| d
    r| d
    l| d *
    EOT
  },
  {
    :title => "97",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obbc",
    :field => <<-EOT,
    ..........
    bb....bbbb
    bb...bbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    bb.b.bbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Al| d
    Bl| . B d
    _ d *
    EOT
  },
  {
    :title => "98",
    :comment => "",
    :controller => FastSimulateController.new(5.0),
    :pattern => "proo",
    :field => <<-EOT,
    ..........
    bbb...b...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb.b
    bbbbbbbb..
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    r| B u d_
    Ar| u d_
    r| B u d_
    * u d_ *
    EOT
  },
  {
    :title => "99",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pbry",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbbb.b
    bbbbbbb...
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "100",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgbb",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    B_ . Br| d
    Br| d
    Ar| B d
    r| d *
    EOT
  },
  {
    :title => "101",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "copo",
    :field => <<-EOT,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbbb..bbb
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "102",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "coob",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb.b.
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Ar| d
    Ar| d
    Br| d
    Ar| d *
    EOT
  },
  {
    :title => "103",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "brob",
    :field => <<-EOT,
    ..........
    bb....bbbb
    bb...bbbbb
    bb...bbbbb
    bb....bbbb
    bbb.bbbbbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Al| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "104",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rgbo",
    :field => <<-EOT,
    ..........
    bbb......b
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb.bbbbb
    bbbbbb.bbb
    EOT
    :input => <<-EOT,
    Al| d
    Br| d
    l| d
    r| d *
    EOT
  },
  {
    :title => "105",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gcbr",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    b..bbbbbbb
    .....bbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "106",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbpo",
    :field => <<-EOT,
    ..........
    bbbb....bb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    EOT
    :input => <<-EOT,
    B_ d
    A_ d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "107",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cobr",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbbb.....b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "108",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oryc",
    :field => <<-EOT,
    ..........
    bbbb....bb
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbb.b.bb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    r| d
    Ar| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "109",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogcb",
    :field => <<-EOT,
    ..........
    bb...bbbbb
    .....bbbbb
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "110",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "crbb",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb...
    bbbbbbbb.b
    bbbbbbbb..
    EOT
    :input => <<-EOT,
    Ar| d
    Ar| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "111",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oyoc",
    :field => <<-EOT,
    ..........
    bb...bbbbb
    bb...bbbbb
    bbb..bbbbb
    bb...bbbbb
    bbb..bbbbb
    bbbb.bbbbb
    bbbb.bbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    l| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "112",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cobc",
    :field => <<-EOT,
    ..........
    bbbb....bb
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    A_ d
    Br| d
    A_ C d
    r| d *
    EOT
  },
  {
    :title => "113",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pgbo",
    :field => <<-EOT,
    ..........
    bbb.....bb
    bbbb....bb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| d
    B_ d *
    EOT
  },
  {
    :title => "114",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcgc",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Al| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "115",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgby",
    :field => <<-EOT,
    ..........
    bbbb....bb
    bbbb...bbb
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    A_ d
    r| d
    Ar| d
    _ d *
    EOT
  },
  {
    :title => "116",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "grbc",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbb.bbb
    bbbbbb.b.b
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    r| B d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "117",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycgy",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbb...b
    bbbbbbb..b
    bbbbbbb..b
    EOT
    :input => <<-EOT,
    r| d
    Br| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "118",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obpc",
    :field => <<-EOT,
    ..........
    bbbb.....b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbb..bbb
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "119",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yccb",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbbb..
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb..b
    EOT
    :input => <<-EOT,
    r| d
    Ar| d
    Br| d
    Ar| d *
    EOT
  },
  {
    :title => "120",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bcbb",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb.bb
    bbbbbbbbb.
    EOT
    :input => <<-EOT,
    Ar| d
    Ar| d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "121",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bboc",
    :field => <<-EOT,
    ..........
    ......bbbb
    ....bbbbbb
    b...bbbbbb
    bb..bbbbbb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    l| d
    _ d
    l| d *
    EOT
  },
  {
    :title => "122",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gocr",
    :field => <<-EOT,
    ..........
    bbbb.....b
    bbbbb....b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb.bbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "123",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcgb",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Br| d
    Ar| d *
    EOT
  },
  {
    :title => "124",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "coco",
    :field => <<-EOT,
    ..........
    b...bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    b...bbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Bl| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "125",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cboo",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "126",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ryco",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb.b
    bbbbbbbb.b
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Br| d
    r| d
    Ar| d
    Br| d *
    EOT
  },
  {
    :title => "127",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ocoy",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb.b.
    EOT
    :input => <<-EOT,
    Br| d
    r| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "128",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pbgc",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbb....
    bbbbbb...b
    bbbbbbb..b
    bbbbbb.b.b
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "129",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbpr",
    :field => <<-EOT,
    ..........
    bbbbb.....
    bbbbb...bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb...bb
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "130",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rycb",
    :field => <<-EOT,
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
    EOT
    :input => <<-EOT,
    Al| d
    l| d
    Br| d
    Al| d *
    EOT
  },
  {
    :title => "131",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "obcr",
    :field => <<-EOT,
    ..........
    b.......bb
    bbb....bbb
    bbbbbb.bbb
    bbb.bb.bbb
    bbb.bb.bbb
    EOT
    :input => <<-EOT,
    Br| d
    Al| d
    r| d
    l| d *
    EOT
  },
  {
    :title => "132",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybgo",
    :field => <<-EOT,
    ..........
    bb....bbbb
    bbb...bbbb
    bbb...bbbb
    bbb..bbbbb
    bbb..bbbbb
    bb.b.bbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| . B d
    B_ d
    l| d *
    EOT
  },
  {
    :title => "133",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcrb",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbbb..b
    bbbbbb...b
    bbbbbbb..b
    bbbbbbbb.b
    bbbbbb..bb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| d
    Ar| d *
    EOT
  },
  {
    :title => "134",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cobo",
    :field => <<-EOT,
    ..........
    bbbbb....b
    bbbbb...bb
    bbbbb....b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    Ar| d
    Br| d *
    EOT
  },
  {
    :title => "135",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgyo",
    :field => <<-EOT,
    ..........
    bb.....bbb
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Bl| d
    l| d
    r| d *
    EOT
  },
  {
    :title => "136",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gboc",
    :field => <<-EOT,
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
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "137",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "grbc",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ...bbbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Al| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "138",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "roby",
    :field => <<-EOT,
    ..........
    bbbbb....b
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "139",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pbor",
    :field => <<-EOT,
    ..........
    bb......bb
    bbb...bbbb
    bbb...bbbb
    bbb...bbbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    d_
    Bl| d
    r| d *
    EOT
  },
  {
    :title => "140",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcbo",
    :field => <<-EOT,
    ..........
    ...bbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbbb.
    .bbbbbbbbb
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Ar| d
    l| d *
    EOT
  },
  {
    :title => "141",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cogy",
    :field => <<-EOT,
    ..........
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    bbb..bbbbb
    EOT
    :input => <<-EOT,
    A_ d
    Br| d
    B_ d
    l| d *
    EOT
  },
  {
    :title => "142",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgbc",
    :field => <<-EOT,
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
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "143",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "coby",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    ..bbbbb..b
    bbbbbbb..b
    bbbbbbb.bb
    ..bbbbbbbb
    EOT
    :input => <<-EOT,
    Ar| d
    Ar| d
    Ar| d
    l| d *
    EOT
  },
  {
    :title => "144",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yrgo",
    :field => <<-EOT,
    ..........
    bb....bbbb
    bb...bbbbb
    bb...bbbbb
    bbb..bbbbb
    bb...bbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Al| d
    Bl| d
    d_ *
    EOT
  },
  {
    :title => "145",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbbc",
    :field => <<-EOT,
    ..........
    bbbbb.....
    bbbbbbb...
    bbbbbbbb..
    bbbbbb.b..
    bbbbbbbb..
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Br| d
    r| d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "146",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "robc",
    :field => <<-EOT,
    ..........
    .....bbbbb
    b...bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Bl| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "147",
    :comment => "青の渡し",
    :controller => FastSimulateController.new,
    :pattern => "crbo",
    :field => <<-EOT,
    ..........
    bbbb.....b
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbbb..bb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    B_ . Br| . Bl d
    Br| d *
    EOT
  },
  {
    :title => "148",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ggcb",
    :field => <<-EOT,
    ..........
    bbbb....bb
    bbbb...bbb
    bbbbb..bbb
    bbbb...bbb
    bbbbb..bbb
    bbbbb.b.bb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    A_ d
    r| d *
    EOT
  },
  {
    :title => "149",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcbb",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbbb.bbb
    bbbbbb..bb
    bbbbb..bbb
    bbbbbb.bbb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "150",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pobc",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbb....bb
    bbbbb...bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    r| d
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "151",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ogpb",
    :field => <<-EOT,
    ..........
    b....bbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    bb.b.bbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Al| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "152",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "oybc",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb...
    bbbbbbb..b
    bbbbbbbb.b
    bbbbbbbb.b
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Br| d
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "153",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gcpy",
    :field => <<-EOT,
    ..........
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb...bbb
    EOT
    :input => <<-EOT,
    B_ d
    A_ d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "154",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycbr",
    :field => <<-EOT,
    ..........
    b.....bbbb
    b...bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    l| d
    Bl| . B d
    l| d *
    EOT
  },
  {
    :title => "155",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bbco",
    :field => <<-EOT,
    ..........
    b....bbbbb
    b...bbbbbb
    b...bbbbbb
    b...bbbbbb
    bbb.bbbbbb
    bb..bbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "156",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cybo",
    :field => <<-EOT,
    ..........
    bbbb......
    bbbbbb...b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Ar| d
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "157",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "opbc",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbbbb....b
    bbbbbb...b
    bbbbbbb..b
    bbbbbb...b
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Br| d
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "158",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pogc",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbbb.b
    bbbbbbb..b
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "159",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycbo",
    :field => <<-EOT,
    ..........
    bbbb...bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbb...bbb
    bbbbb..bbb
    EOT
    :input => <<-EOT,
    r| d
    Br| d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "160",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgbo",
    :field => <<-EOT,
    ..........
    bb.....bbb
    bbb...bbbb
    bbb...bbbb
    bbb..bbbbb
    bb..b.bbbb
    EOT
    :input => <<-EOT,
    Al| d
    d_
    Ar| d
    l| d *
    EOT
  },
  {
    :title => "161",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "poco",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb.b
    bbbbbbbb..
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "162",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgco",
    :field => <<-EOT,
    ..........
    bb....bbbb
    bb...bbbbb
    bb...bbbbb
    bb..bbbbbb
    bb.bbbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Bl| d
    Al| d
    d_ *
    EOT
  },
  {
    :title => "163",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cpco",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb.bbb
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "164",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yobb",
    :field => <<-EOT,
    ..........
    ....bbbbbb
    ...bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    .bbbbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Al| d
    Al| d
    Al| d *
    EOT
  },
  {
    :title => "165",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "prcb",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbbb...bb
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Br| d
    Ar| d *
    EOT
  },
  {
    :title => "166",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pooc",
    :field => <<-EOT,
    ..........
    bbbb....bb
    bbbbb...bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb...bb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Ar| . A d
    r| d *
    EOT
  },
  {
    :title => "167",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bpcb",
    :field => <<-EOT,
    ..........
    bbb....bbb
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    bbbb.bbbbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    A_ d
    Br| d
    Br| d
    d_ *
    EOT
  },
  {
    :title => "168",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcyc",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b.bbbbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Al| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "169",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "crpo",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbbb.bb
    bbbbbb.b..
    bbbbbbbbb.
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Br| d
    Br| d *
    EOT
  },
  {
    :title => "170",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cogr",
    :field => <<-EOT,
    ..........
    bbbb.....b
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbbb.bb
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    r| d
    r| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "171",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbpr",
    :field => <<-EOT,
    ..........
    bbb.....bb
    bbb....bbb
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    EOT
    :input => <<-EOT,
    d_
    Ar| d
    B_ d
    r| d *
    EOT
  },
  {
    :title => "172",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcgb",
    :field => <<-EOT,
    ..........
    bbbbb....b
    bbbbbb...b
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb.bbb
    bbbbbb.bbb
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "173",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cobb",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbb....bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb.bbb
    bbbbbb..bb
    EOT
    :input => <<-EOT,
    Ar| d
    Br| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "174",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pcbc",
    :field => <<-EOT,
    ..........
    bbb...bbbb
    bbb...bbbb
    bbb...bbbb
    bbbb..bbbb
    bbbb..bbbb
    bbb...bbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Al| d
    d_ *
    EOT
  },
  {
    :title => "175",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ycbb",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    b..bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Al| d
    Al| d
    l| d *
    EOT
  },
  {
    :title => "176",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbro",
    :field => <<-EOT,
    ..........
    bbbbb....b
    bbbbbb...b
    bbbbb....b
    bbbbbb...b
    bbbbbbb.bb
    bbbbbbbb.b
    EOT
    :input => <<-EOT,
    Ar| d
    Ar| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "177",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "brcb",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    b.bbbbbbbb
    b.bbbbbbbb
    b..bbbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Al| d
    Bl| d
    Al| d *
    EOT
  },
  {
    :title => "178",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "orcb",
    :field => <<-EOT,
    ..........
    bbb...bbbb
    bbb...bbbb
    bbb...bbbb
    bbbb..bbbb
    bbbbb.bbbb
    bbb...bbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Br| d
    Al| d
    A_ d
    d_ *
    EOT
  },
  {
    :title => "179",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "opcy",
    :field => <<-EOT,
    ..........
    bbbb...bbb
    bbbb...bbb
    bbbb...bbb
    bbbb...bbb
    bbbb..bbbb
    bbbb..bbbb
    EOT
    :input => <<-EOT,
    r| d
    Br| d
    Br| d
    d_ *
    EOT
  },
  {
    :title => "180",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rcoy",
    :field => <<-EOT,
    ..........
    bbbb....bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb.bbbb
    bbbbb.bbbb
    bbbbb..bbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    Br| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "181",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "grcb",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    b..bbbbbbb
    b..bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    Al| d
    Al| d *
    EOT
  },
  {
    :title => "182",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybpc",
    :field => <<-EOT,
    ..........
    b...bbbbbb
    b...bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    Bl| d
    Bl| d
    l| d *
    EOT
  },
  {
    :title => "183",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybgo",
    :field => <<-EOT,
    ..........
    .....bbbbb
    b...bbbbbb
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb.bbbbbbb
    EOT
    :input => <<-EOT,
    l| d
    l| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "184",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gpbc",
    :field => <<-EOT,
    ..........
    bb...bbbbb
    b....bbbbb
    bb...bbbbb
    bb...bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    l| d
    l| d
    l| d *
    EOT
  },
  {
    :title => "185",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "pbgo",
    :field => <<-EOT,
    ..........
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbb..b
    bbbbbbb..b
    bbbbbb.b.b
    EOT
    :input => <<-EOT,
    Br| d
    Br| . B d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "186",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "ybpoc",
    :field => <<-EOT,
    ..........
    bbbbbb...b
    bb...b...b
    bbbbbb...b
    bbbbbbb..b
    bbbbbbb..b
    bbbbbbb..b
    bbb.bbbb.b
    EOT
    :input => <<-EOT,
    r| d
    r| d
    Br| d
    Br| d
    l| d *
    EOT
  },
  {
    :title => "187",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bpcor",
    :field => <<-EOT,
    ..........
    ...bbbbbbb
    ...bbbbbbb
    ...bbbbbbb
    ..bbbbbbbb
    ..bbbbbbbb
    .b.b....bb
    .bbbbbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    l| d
    Al| d
    Bl| d
    r| d *
    EOT
  },
  {
    :title => "188",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "rbbco",
    :field => <<-EOT,
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
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Ar| C d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "189",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gcpbc",
    :field => <<-EOT,
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
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Br| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "190",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cgbor",
    :field => <<-EOT,
    ..........
    b...bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bb..bbbbbb
    bbb.bbbbbb
    b......bbb
    EOT
    :input => <<-EOT,
    Bl| d
    Bl| d
    Al| d
    l| d
    d_ *
    EOT
  },
  {
    :title => "191",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gbcbo",
    :field => <<-EOT,
    ..........
    bbbbb...bb
    bbbb....bb
    bbbbb...bb
    bbbbb..bbb
    bbbbb..bbb
    bbbbb..bbb
    bbbb...bbb
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "192",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "boycr",
    :field => <<-EOT,
    ..........
    bbbbb.....
    bbbbb....b
    bbbbbb...b
    bbbbbb...b
    bbbbbb...b
    bbbbbbbb.b
    bbbbb.bbbb
    EOT
    :input => <<-EOT,
    r| d
    r| d
    r| d
    Ar| d
    r| d *
    EOT
  },
  {
    :title => "193",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bycgo",
    :field => <<-EOT,
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
    EOT
    :input => <<-EOT,
    Ar| d
    r| d
    Ar| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "194",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "yycgb",
    :field => <<-EOT,
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
    EOT
    :input => <<-EOT,
    r| d
    r| d
    Br| d
    Br| d
    A_ d *
    EOT
  },
  {
    :title => "195",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "cbcor",
    :field => <<-EOT,
    ..........
    bbbb......
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb.b
    bbbbbbbbb.
    EOT
    :input => <<-EOT,
    r| d
    Ar| . A d
    r| d
    Br| d
    r| d *
    EOT
  },
  {
    :title => "196",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bopcr",
    :field => <<-EOT,
    ..........
    bbb.....bb
    bbb....bbb
    bbbb...bbb
    bbbb...bbb
    bbb....bbb
    bbbbbb.bbb
    EOT
    :input => <<-EOT,
    r| d
    A_ C d
    r| d
    Al| d
    r| d *
    EOT
  },
  {
    :title => "197",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bcrpo",
    :field => <<-EOT,
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
    EOT
    :input => <<-EOT,
    Al| d
    Al| d
    Al| d
    l| d
    Bl| d *
    EOT
  },
  {
    :title => "198",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "propc",
    :field => <<-EOT,
    ..........
    bb.....bbb
    bb....bbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbbb.bbbbb
    EOT
    :input => <<-EOT,
    Bl| d
    Bl| d
    Bl| d
    r| d
    l| d *
    EOT
  },
  {
    :title => "199",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgccy",
    :field => <<-EOT,
    ..........
    bbbb.....b
    bbbbb....b
    bbbbb...bb
    bbbbbb..bb
    bbbbbb..bb
    bbbbbb...b
    bbbbbb.bbb
    EOT
    :input => <<-EOT,
    Ar| d
    r| d
    r| d
    r| d
    r| d *
    EOT
  },
  {
    :title => "200",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "gocgb",
    :field => <<-EOT,
    ..........
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbb.bb
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    Br| d
    Br| d
    Ar| d *
    EOT
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
