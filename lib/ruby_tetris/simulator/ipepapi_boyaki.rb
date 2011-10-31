#!/usr/local/bin/ruby -Ku


$LOAD_PATH << '..'
require "simulator"

library = [
  {
    :title => "次の一テト",
    :author => "いぺぱぴ",
    :date => "1999-04-30",
    :url => "http://homepage3.nifty.com/tgm/boyakilog99b.html#990430",
    :difficulty => 3,
    :comment => "緑を立てて紫の受けを作る",
    :controller => SimulateController.new,
    :pattern => "gp",
    :field => <<-EOT,
    ....c.....
    ....c.....
    c..cc.....
    ccccccccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => <<-EOT,
    Al| r d
    Al| d *
    EOT
  },

  {
    :title => "次の一テト(紫編)",
    :author => "いぺぱぴ",
    :date => "1999-06-27",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9906.html#990627",
    :difficulty => 1,
    :comment => "これであなたも３０秒縮む！",
    :controller => SimulateController.new,
    :pattern => "p",
    :field => <<-EOT,
    ccccccc...
    ccccccc...
    cccccccc..
    ccccccccc.
    EOT
    :input => %[r| B d *],
  },

  {
    :title => "次の一テト(オレンジ編)",
    :author => "いぺぱぴ",
    :date => "1999-06-27",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9906.html#990627",
    :difficulty => 1,
    :comment => "これであなたも３０秒縮む！",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    ccccccc...
    cccccccc..
    cccccccc..
    ccccccccc.
    EOT
    :input => %[r| B d *],
  },

  {
    :title => "赤をタイミング押しで右端に！",
    :author => "いぺぱぴ",
    :date => "1999-06-21",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9906.html#990621",
    :difficulty => 5,
    :comment => "噂のシンクロ？",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    ..cccc....
    cccccc....
    ccccccc.c.
    ccccccc.c.
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[* r 10 r 10 Br| d *],
  },

  {
    :title => "入らず固まった赤",
    :author => "いぺぱぴ",
    :date => "1999-06-17",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9906.html#990617",
    :difficulty => 4,
    :comment => "患部に触れずに考えてそのラインをきれいに消せないかを検討することが気持ち良い回復への第一歩",
    :controller => SimulateController.new,
    :pattern => "yopcb",
    :field => <<-EOT,
    .rrrr.....
    ...cc.c...
    ..cccccccc
    ..cccccccc
    .ccccccccc
    .ccccccccc
    .ccccccccc
    .ccccccccc
    EOT
    :input => <<-EOT,
    r| d
    Br| d
    Br| d
    r| A C d
    Al| C d *
    EOT
  },

  {
    :title => "伏せによるオレンジの高速配置",
    :author => "いぺぱぴ",
    :date => "1999-06-13",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9906.html#990613",
    :difficulty => 1,
    :comment => "右にためて→逆回転先行入力→逆回転",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    cc..c.....
    cccccc.cc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[Br| A d *],
  },

  {
    :title => "操作最適化の例題(水色)",
    :author => "いぺぱぴ",
    :date => "1999-08-01",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9907.html#990801",
    :difficulty => 2,
    :comment => "回転・移動の順でなくてもよい",
    :controller => SimulateController.new,
    :pattern => "c",
    :field => <<-EOT,
    rrrr......
    rrrr......
    rrrrrr....
    rrrrrr....
    rrrrrrr...
    rrrrrrrrr.
    rrrrrrrrr.
    EOT
    :input => %[r| B l d *],
  },

  {
    :title => "操作最適化の例題(紫)",
    :author => "いぺぱぴ",
    :date => "1999-08-01",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9907.html#990801",
    :difficulty => 2.5,
    :comment => "回転・移動の順でなければならない",
    :controller => SimulateController.new,
    :pattern => "p",
    :field => <<-EOT,
    rrrr......
    rrrr......
    rrrrrr....
    rrrrrr....
    rrrrrrr...
    rrrrrrrrr.
    rrrrrrrrr.
    EOT
    :input => %[r| B l d *],
  },

  {
    :title => "青のでんぐり逆上がり",
    :author => "いぺぱぴ",
    :date => "1999-08-01",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9907.html#990801",
    :difficulty => 5,
    :comment => "上でためてもでんぐり返りで引っ掛かるので真空入れはできない(by いけだ)",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ...ccc....
    .....c....
    ....cc....
    ....cc....
    ...cccc...
    ...cccc...
    EOT
    :input => %[A* l . l A r+ Br d *],
  },

  {
    :title => "赤シンクロ",
    :author => "いぺぱぴ",
    :date => "1999-08-01",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9907.html#990801",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    cccccc....
    cccccc....
    cccccc....
    cccccc..c.
    ccccccccc.
    EOT
    :input => %[r* r r Br| d *],
  },

  {
    :title => "オレンジの怪しげな回転入れ",
    :author => "いぺぱぴ",
    :date => "1999-07-30",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9907.html#990730",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    ....ccc...
    c...c.cc..
    ccc...ccc.
    ccccccccc.
    EOT
    :input => %[Bl| . B d *],
  },

  {
    :title => "序盤・水色を置くなら?",
    :author => "いぺぱぴ",
    :date => "1999-08-23",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9908.html#990823",
    :difficulty => nil,
    :comment => "扁平率理論",
    :controller => SimulateController.new(0.01),
    :pattern => "cpg",
    :field => <<-EOT,
    bb........
    bbbb...bb.
    bbbbb.bbb.
    bbbbbbbbb.
    EOT
    :input => <<-EOT,
    B* r d_
    * d_
    l| r A d_ *
    EOT
  },

  {
    :title => "オレンジを置くなら?",
    :author => "いぺぱぴ",
    :date => "1999-08-16",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9908.html#990816",
    :difficulty => nil,
    :comment => "左１回転で左端か、それとも２回転で左端か",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    ...cccc...
    ...cccccc.
    ccccccccc.
    EOT
    :input => %[Al| d *],
  },

  {
    :title => "緑を置くなら?",
    :author => "いぺぱぴ",
    :date => "1999-08-06",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9908.html#990806",
    :difficulty => 2,
    :comment => "右から2,3列目に立てるのはそんなに悪くない",
    :controller => SimulateController.new,
    :pattern => "gbr",
    :field => <<-EOT,
    ccccccc...
    ccccccc...
    ccccccc...
    ccccccccc.
    EOT
    :input => <<-EOT,
    Br| l d
    r| d
    Br| d *
    EOT
  },

  {
    :title => "でんぐり逆上がり待ち",
    :author => "いぺぱぴ",
    :date => "1999-09-06",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9909.html#990906",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "bpb",
    :field => <<-EOT,
    ....cc....
    ...ccc....
    c..ccc....
    c..cccc.c.
    c.ccccccc.
    EOT
    :input => <<-EOT,
    B* r d
    * d
    A* l . l A r+ Br d *
    EOT
  },

  {
    :title => "20G・青を右下に入れる",
    :author => "いぺぱぴ",
    :date => "1999-09-04",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9909.html#990904",
    :difficulty => 3,
    :comment => "右ため出現→ＡＢＡＢ",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    cc.....c..
    cccccccc..
    cccccccc..
    cccccc....
    cccccccc.c
    EOT
    :input => %[r| Ar Br A B d *],
  },

  {
    :title => "20G・青を右下に入れる限定版",
    :author => "いぺぱぴ",
    :date => "1999-09-04",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9909.html#990904",
    :difficulty => 4,
    :comment => "A B A Bでは越えられない",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    cc.....c..
    cccccc.c..
    cccccccc..
    cccccc....
    cccccccc.c
    EOT
    :input => %[Br| Ar C B d *],
  },

  {
    :title => "赤の配置は？",
    :author => "いぺぱぴ",
    :date => "1999-10-27",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9910.html#991027",
    :difficulty => 2,
    :comment => "5列目、またシンクロ",
    :controller => SimulateController.new,
    :pattern => "rc",
    :field => <<-EOT,
    ...c......
    ..cc......
    ccccc.....
    ccccc.c...
    ccccccccc.
    ccccccccc.
    EOT
    :input => <<-EOT,
    * l A d
    Ar| d *
    EOT
  },

  {
    :title => "詰めＴＧＭ",
    :author => "ZON",
    :date => "1999-10-20",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9910.html#991020",
    :difficulty => 3,
    :comment => "最初の2手がどうやっても置けないように思えて、 その間に隠された回答の感触が楽しい",
    :controller => SimulateController.new,
    :pattern => "prob",
    :field => <<-EOT,
    cc......cc
    cc......cc
    ccc....ccc
    EOT
    :input => <<-EOT,
    Al| d
    u_ d
    Br* r| B d
    A* C d
    *
    EOT
  },

  {
    :title => "詰めＴＧＭ",
    :author => "いぺぱぴ",
    :date => "1999-10-10",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9910.html#991010",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "ccrgooo",
    :field => <<-EOT,
    .......b..
    b.........
    EOT
  },

  {
    :title => "オレンジの置き方と操作法",
    :author => "いぺぱぴ",
    :date => "1999-11-14",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9911.html#991114",
    :difficulty => 1,
    :comment => "操作を極めなくても2-3列目には置ける(by いけだ)",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    c....c....
    ccc.ccc...
    cccccccc..
    cccccccc..
    ccccccccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[Al| d *],
  },

  {
    :title => "オレンジの置き方と操作法",
    :author => "GOO",
    :date => "1999-11-14",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9911.html#991114",
    :difficulty => 3,
    :comment => "右ため左回転出現、出現直後にもう一度左回転、右端についたらレバーを放して左回転して下で固定",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    c.c.c.....
    cccccc....
    ccccccc...
    cccccccc..
    cccccccc..
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[Ar* Cr| A d *],
  },

  {
    :title => "一ライン消しを回避すると?",
    :author => "いぺぱぴ",
    :date => "1999-12-23",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9912.html#991223",
    :difficulty => 2,
    :comment => "3ラインまで成長させようとか思っていると緑が来て困る",
    :controller => SimulateController.new,
    :pattern => "gcg",
    :field => <<-EOT,
    cc........
    cc..cc....
    ccc.ccc...
    ccccccc...
    ccccccc...
    cccccccc..
    ccccccccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => <<-EOT,
    Ar| d
    Ar| d
    * r . r d *
    EOT
  },

  {
    :title => "水色の置き方",
    :author => "いぺぱぴ",
    :date => "1999-12-12",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9912.html#991212",
    :difficulty => 2,
    :comment => "一度反対を向けて出現させ、２回転して戻した方、要注意。",
    :controller => SimulateController.new,
    :pattern => "c",
    :field => <<-EOT,
    bbbbbbb...
    bbbbbbbb..
    bbbbbbb...
    bbbbbbbb..
    EOT
    :input => %[Br| l d *],
  },

  {
    :title => "青の置き方",
    :author => "いぺぱぴ",
    :date => "1999-12-12",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9912.html#991212",
    :difficulty => 1,
    :comment => "先入観によって見えなくなっている形がある",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    cccccc....
    ccccccc...
    ccccccc...
    cccccc....
    cccccccc..
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[r| l d *],
  },

  {
    :title => "詰めＴＧＭ 図1 名作から拝借",
    :author => "いぺぱぴ",
    :date => "2000-02-22",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000222",
    :difficulty => 2,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "ccy",
    :field => <<-EOT,
    bbbbbb....
    bbbbbb....
    bbbbbb....
    EOT
    :input => <<-EOT,
    Br| d
    Ar| d
    r| d *
    EOT
  },

  {
    :title => "詰めＴＧＭ 図2 ちょっと変形",
    :author => "いぺぱぴ",
    :date => "2000-02-22",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000222",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "ccy",
    :field => <<-EOT,
    ggggggg...
    ggggggg...
    gggggg....
    ggggggg..g
    EOT
    :input => <<-EOT,
    A* Cr| l d
    Br| d
    r| d *
    EOT
  },

  {
    :title => "詰めＴＧＭ 図3: 少し回転入れ",
    :author => "いぺぱぴ",
    :date => "2000-02-22",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000222",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "cpb",
    :field => <<-EOT,
    gggg...ggg
    gggg...ggg
    ggg...gggg
    gggg...ggg
    EOT
    :input => <<-EOT,
    r| A C d
    r| A C d
    r| d *
    EOT
  },

  {
    :title => "詰めＴＧＭ 図4: 初手の感覚",
    :author => "いぺぱぴ",
    :date => "2000-02-22",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000222",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "boc",
    :field => <<-EOT,
    gggggg....
    gggggg....
    ggggggg...
    gggggggg.g
    EOT
    :input => <<-EOT,
    A* Cr . r . r d
    Br| . B d
    r| d *
    EOT
  },

  {
    :title => "各色１回使用での詰めテトリス",
    :author => "いぺぱぴ",
    :date => "2000-02-17",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000217",
    :difficulty => nil,
    :comment => "ブロック順不同",
    :controller => SimulateController.new,
    :pattern => "ybogpcr",
    :field => <<-EOT,
    ccc.......
    ccc.......
    ccc.......
    ccc.......
    EOT
  },

  {
    :title => "次の１手とその操作は?",
    :author => "いぺぱぴ",
    :date => "2000-02-16",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000216",
    :difficulty => nil,
    :comment => "左から3-4列目の方が良い形",
    :controller => SimulateController.new,
    :pattern => "g",
    :field => <<-EOT,
    ....cc....
    ....cc....
    ...ccccc..
    c.cccccc..
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[l| Ar d *],
  },

  {
    :title => "シンクロ率向上委員会",
    :author => "いぺぱぴ",
    :date => "2000-02-15",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000215",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    cccccc....
    cccccc....
    cccccc..c.
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[* r . r . Ar| d *],
  },

  {
    :title => "図2-1: 赤シンクロ(右)",
    :author => "いぺぱぴ",
    :date => "2000-02-15",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000215",
    :difficulty => 5,
    :comment => "右ため〜タイミング狙って回転〜左入れてから下入れで接着",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    cccccc....
    ccccccc...
    ccccccc.c.
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[r* r r Ar| d *],
  },

  {
    :title => "図2-2: 赤シンクロ(左)",
    :author => "いぺぱぴ",
    :date => "2000-02-15",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000215",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    ....cccccc
    ....cccccc
    ..c.cccccc
    .ccccccccc
    .ccccccccc
    EOT
    :input => %[l* l l Al| d *],
  },

  {
    :title => "図3 紫シンクロ立て",
    :author => "いぺぱぴ",
    :date => "2000-02-15",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000215",
    :difficulty => 4,
    :comment => "左から4列目に隙間ができるのも残念だという場合のあがきとして意外と使える",
    :controller => SimulateController.new,
    :pattern => "p",
    :field => <<-EOT,
    cccccc....
    cccccc....
    ccccccc...
    cccccccc..
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[r| Al d *],
  },

  {
    :title => "図4 緑シンクロ",
    :author => "いぺぱぴ",
    :date => "2000-02-15",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000215",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "g",
    :field => <<-EOT,
    ....ccccc.
    ....ccccc.
    .c..ccccc.
    cc..ccccc.
    ccccccccc.
    EOT
    :input => %[A* l . Al B l d *],
  },

  {
    :title => "詰めＴＧＭ",
    :author => "ＫＪＵ",
    :date => "2000-02-13",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000213",
    :difficulty => 4,
    :comment => "オレンジの伏せがヒント",
    :controller => SimulateController.new,
    :pattern => "rboygr",
    :field => <<-EOT,
    cc.......c
    cc.......c
    ccc.....cc
    ccc.....cc
    EOT
    :input => <<-EOT,
    r| d
    * r d
    Bl| A d
    l| d
    Ar| d
    r| d *
    EOT
  },

  {
    :title => "詰め20G",
    :author => "いぺぱぴ",
    :date => "2000-02-13",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000213",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "pygob",
    :field => <<-EOT,
    cccc......
    cccc......
    ccccc.....
    cccccc...c
    EOT
    :input => <<-EOT,
    A* Br d
    * d
    r| d
    Ar* Cr| Ar B d
    Ar| C d *
    EOT
  },

  {
    :title => "図5-1 青は立つか?",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000209",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ...ooo....
    ...o.c....
    .....c....
    .....c....
    EOT
    :input => %[l| r . r B d *],
  },

  {
    :title => "図5-2 青は入るか?",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000209",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ...ccc....
    ...c.c....
    ...c.c....
    .....c....
    EOT
    :input => %[Bl| . B r . r A d *],
  },

  {
    :title => "図5-3 青は入るか?",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000209",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ...bbpp...
    ...bppoo..
    ...b..go..
    .....ggo..
    .....g....
    EOT
    :input => %[l| r . r A d *],
  },

  {
    :title => "図5-4 青は入るか?",
    :author => "いぺぱぴ",
    :date => "2000-02-09",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000209",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ...cccc...
    ...ccccc..
    ...c..cc..
    ...c.ccc..
    .....c....
    EOT
    :input => %[Bl| . B r . r B d *],
  },

  {
    :title => "図4-1: 水色は立つか?",
    :author => "いぺぱぴ",
    :date => "2000-02-08",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000208",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "c",
    :field => <<-EOT,
    ..ggrrrr..
    ...gg.....
    EOT
  },

  {
    :title => "図4-2: 水色は立つか?",
    :author => "いぺぱぴ",
    :date => "2000-02-08",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000208",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "c",
    :field => <<-EOT,
    ..rrrrpp..
    .....pp...
    EOT
  },

  {
    :title => "図4-3: 4-2と同様のはず",
    :author => "いぺぱぴ",
    :date => "2000-02-08",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000208",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "c",
    :field => <<-EOT,
    ..cccpp...
    ...cpp....
    EOT
  },

  {
    :title => "詰めＴＧＭ、20Gではどうか?",
    :author => "いぺぱぴ",
    :date => "2000-02-08",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000208",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "bcoo",
    :field => <<-EOT,
    cc......gb
    cc.....ggb
    cc.c...gbb
    ccccc.cccc
    EOT
  },

  {
    :title => "図0: 緑は入る",
    :author => "いぺぱぴ",
    :date => "2000-02-07",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000207",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "g",
    :field => <<-EOT,
    ..ooo.....
    ..o.bb....
    ....b.....
    ....b.....
    EOT
    :input => %[Al| B A d *],
  },

  {
    :title => "図1: 緑は入るはず",
    :author => "いぺぱぴ",
    :date => "2000-02-07",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000207",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "g",
    :field => <<-EOT,
    ..ooo.....
    ..o.b.....
    ....b.....
    ...bb.....
    EOT
    :input => %[Al| B A d *],
  },

  {
    :title => "図2: 紫は入らないかな",
    :author => "いぺぱぴ",
    :date => "2000-02-07",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000207",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "p",
    :field => <<-EOT,
    .bbb......
    .o.b......
    .o........
    .oo.......
    EOT
  },

  {
    :title => "図3: これは紫は入る？",
    :author => "いぺぱぴ",
    :date => "2000-02-07",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0002.html#000207",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "p",
    :field => <<-EOT,
    .bbb......
    .o.b......
    .o........
    .oo.......
    EOT
  },

  {
    :title => "意外な紫待ち",
    :author => "いぺぱぴ",
    :date => "2000-03-21",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0003.html#000321",
    :difficulty => 2,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "cp",
    :field => <<-EOT,
    b.........
    b..bb.....
    bbbbb.....
    bbbbb.....
    bbbbbbb...
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
    :input => <<-EOT,
    B* d
    Bl| A d *
    EOT
  },

  {
    :title => "紫と緑はセットで",
    :author => "いぺぱぴ",
    :date => "2000-03-21",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0003.html#000321",
    :difficulty => 1,
    :comment => "左側に緑の受けがなくなるから紫は左端に立てる",
    :controller => SimulateController.new,
    :pattern => "pg",
    :field => <<-EOT,
    ....cc....
    ....ccc...
    c...ccccc.
    cc.cccccc.
    ccccccccc.
    EOT
    :input => <<-EOT,
    l| Bl d
    Bl| d *
    EOT
  },

  {
    :title => "次の水色の配置は？",
    :author => "いぺぱぴ",
    :date => "2000-03-20",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0003.html#000320",
    :difficulty => 2,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "cg",
    :field => <<-EOT,
    r.........
    r..rr.....
    rrrrr.....
    rrrrr.....
    rrrrrrr...
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    EOT
    :input => <<-EOT,
    * Ar d
    r| l d *
    EOT
  },

  {
    :title => "緑を平たく置いて紫待ち",
    :author => "いぺぱぴ",
    :date => "2000-03-20",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0003.html#000320",
    :difficulty => 2,
    :comment => "高くなってきて耐えたいときなどにはかなり有効",
    :controller => SimulateController.new,
    :pattern => "gp",
    :field => <<-EOT,
    ..ccc.....
    ccccc..cc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => <<-EOT,
    * l d
    l| B A d *
    EOT
  },

  {
    :title => "次の水色の配置は？",
    :author => "いぺぱぴ",
    :date => "2000-03-04",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0003.html#000304",
    :difficulty => 1,
    :comment => "左回転IRS出現、左1マス移動、左回転、接着",
    :controller => SimulateController.new,
    :pattern => "cg",
    :field => <<-EOT,
    ....rr....
    ....rr....
    ....rrrr..
    rrrrrrrrr.
    rrrrrrrrr.
    EOT
    :input => <<-EOT,
    A* l C d
    Al| d *
    EOT
  },

  {
    :title => "赤の操作方法は？",
    :author => "いぺぱぴ",
    :date => "2000-04-28",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0004.html#000428",
    :difficulty => 2,
    :comment => "左、左ため、回転",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    ....c.....
    ....cc....
    ...cccc...
    ..ccccc...
    .ccccccccc
    .ccccccccc
    .ccccccccc
    .ccccccccc
    EOT
    :input => %[* l . l A l| d *],
  },

  {
    :title => "1. 橙をどう処理する?",
    :author => "いぺぱぴ",
    :date => "2000-04-09",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0004.html#000409",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    ....p.....
    ...pp.....
    c..cp...c.
    cccccc..c.
    .ccccccccc
    cc.ccccccc
    ccccccccc.
    EOT
    :input => %[B* r . Br| Ar d *],
  },

  {
    :title => "1. 水色をどう処理する?",
    :author => "いぺぱぴ",
    :date => "2000-04-07",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0004.html#000407",
    :difficulty => 5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "cg",
    :field => <<-EOT,
    ...oo.....
    o..oo...o.
    oooooo..oo
    o.oooooooo
    ooooooooo.
    ooooooooo.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    EOT
    :input => <<-EOT,
    B* r . Br| Ar d
    r| d *
    EOT
  },

  {
    :title => "1.紫はどこに?(20G)",
    :author => "いぺぱぴ",
    :date => "2000-05-31",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0005.html#000531",
    :difficulty => 1,
    :comment => "紫の後には緑が来ることを想定しておく",
    :controller => SimulateController.new,
    :pattern => "pg",
    :field => <<-EOT,
    ....cc....
    b...cc....
    bbb.ccccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => <<-EOT,
    Al| d
    Al| d *
    EOT
  },

  {
    :title => "2.紫はどこに?(20G)",
    :author => "いぺぱぴ",
    :date => "2000-05-31",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0005.html#000531",
    :difficulty => 1,
    :comment => "水色の後に緑がくるかもしれない",
    :controller => SimulateController.new,
    :pattern => "pcg",
    :field => <<-EOT,
    ....cc....
    b...cc....
    bbb.ccccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => <<-EOT,
    Al| d
    l| d
    * r d *
    EOT
  },

  {
    :title => "右端に入れる操作は？(20G)",
    :author => "いぺぱぴ",
    :date => "2000-05-29",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0005.html#000529",
    :difficulty => 5,
    :comment => "2フレームの間に押せば成功",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    cc..cc....
    cccccc....
    cccccc.cc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[r* r r Ar| d *],
  },

  {
    :title => "赤をどう使う?",
    :author => "いぺぱぴ",
    :date => "2000-05-12",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0005.html#000512",
    :difficulty => nil,
    :comment => "３ライン消しをすることは、次の２〜１ライン消しを誘発する",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    c..cc.....
    cccccccc..
    cccccccc..
    cccccccc..
    ccccccccc.
    ccccccccc.
    ccccccccc.
    EOT
  },

  {
    :title => "1. 20G、紫の置き場は？",
    :author => "いぺぱぴ",
    :date => "2000-05-01",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0005.html#000501",
    :difficulty => nil,
    :comment => "赤の受けを用意したいから8-9列目より6-7列目におくとハマるが以外な待ちができる",
    :controller => SimulateController.new,
    :pattern => "prpo",
    :field => <<-EOT,
    cc........
    cc.ccc....
    cccccccc..
    ccccccccc.
    ccccccccc.
    EOT
    :input => <<-EOT,
    B* r . r d
    r| Ar d
    * d
    Bl| A d *
    EOT
  },

  {
    :title => "1. 20G、紫の置き場は？",
    :author => "いぺぱぴ",
    :date => "2000-05-01",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0005.html#000501",
    :difficulty => nil,
    :comment => "赤の受けを用意したいから8-9列目より6-7列目におくとハマる",
    :controller => SimulateController.new,
    :pattern => "pgc",
    :field => <<-EOT,
    cc........
    cc.ccc....
    cccccccc..
    ccccccccc.
    ccccccccc.
    EOT
    :input => <<-EOT,
    B* r . r d
    Al| d
    * d *
    EOT
  },

  {
    :title => "青の操作方法は?(20G)",
    :author => "いぺぱぴ",
    :date => "2000-06-29",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0006.html#000629",
    :difficulty => 1.5,
    :comment => "→Ｂ←↓",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ....g.....
    ...gg.....
    ..cg......
    ccccccc...
    ccccccccc.
    EOT
    :input => %[* r B l d *],
  },

  {
    :title => "オレンジの操作方法は?(20G)",
    :author => "いぺぱぴ",
    :date => "2000-06-29",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0006.html#000629",
    :difficulty => 1.5,
    :comment => "左右対象の操作で問題無く入る",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    ....p.....
    ....pp....
    .....p....
    ccccccc...
    ccccccccc.
    EOT
    :input => %[* l A r d *],
  },

  {
    :title => "水色はどこに?(20G)",
    :author => "いぺぱぴ",
    :date => "2000-06-25",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0006.html#000625",
    :difficulty => nil,
    :comment => "6-7に置くと紫→黄のツモでハマる",
    :controller => SimulateController.new,
    :pattern => "cpy",
    :field => <<-EOT,
    ...gg.....
    ggggg.....
    ggggggg...
    ggggggggg.
    ggggggggg.
    ggggggggg.
    EOT
    :input => <<-EOT,
    r| B l d
    l| r d
    * r d *
    EOT
  },

  {
    :title => "青は脱出不能？",
    :author => "いぺぱぴ",
    :date => "2000-06-25",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0006.html#000625",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    .ccc......
    ...c......
    EOT
    :input => %[Bl| . Bl . Bl A 15 B 15 A 15 d *],
  },

  {
    :title => "(20G)青は左端に届く",
    :author => "いぺぱぴ",
    :date => "2000-07-25",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0007.html#000725",
    :difficulty => 1,
    :comment => "届くものは回さずに",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ...ccccc..
    ...cccccc.
    .c.cccccc.
    .cccccccc.
    ccccccccc.
    EOT
    :input => %[Al| d *],
  },

  {
    :title => "(20G)オレンジは右端に届く",
    :author => "いぺぱぴ",
    :date => "2000-07-25",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0007.html#000725",
    :difficulty => 1,
    :comment => "届くものは回さずに",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    ccccccc...
    ccccccc...
    ccccccc.c.
    ccccccc.c.
    ccccccc.cc
    EOT
    :input => %[Br| d *],
  },

  {
    :title => "水色の置き場所(20G)",
    :author => "いぺぱぴ",
    :date => "2000-07-25",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0007.html#000725",
    :difficulty => 2,
    :comment => "平たいと嬉しい？",
    :controller => SimulateController.new,
    :pattern => "cpyg",
    :field => <<-EOT,
    b.........
    bbb.......
    yyooo.....
    yyorrrr...
    EOT
    :input => <<-EOT,
    * r d
    Al| d
    * d
    r| l d
    *
    EOT
  },

  {
    :title => "(20G)高いと水色の配置は",
    :author => "いぺぱぴ",
    :date => "2000-07-25",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0007.html#000725",
    :difficulty => nil,
    :comment => "平らにしておかないと黄色がちょっと気持ち悪い",
    :controller => SimulateController.new,
    :pattern => "cp",
    :field => <<-EOT,
    ....r.....
    ..rrrrr...
    rrrrrrr...
    rrrrrrrr..
    rrrrrrrr..
    rrrrrrrrr.
    rrrrrrrrr.
    EOT
    :input => <<-EOT,
    * l d
    Al| B d *
    EOT
  },

  {
    :title => "オレンジを左端に(20G)",
    :author => "いぺぱぴ",
    :date => "2000-07-20",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0007.html#000720",
    :difficulty => 1.5,
    :comment => "左に入れっぱなせば左に届く",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    ....cc....
    cc..ccc...
    ccc.ccccc.
    ccccccccc.
    EOT
    :input => %[l| A l d *],
  },

  {
    :title => "類型: 水色や紫を左端に(20G)",
    :author => "いぺぱぴ",
    :date => "2000-07-20",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0007.html#000720",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "c",
    :field => <<-EOT,
    ...yy.....
    .y.yyyy...
    yyyyyyyyy.
    yyyyyyyyy.
    EOT
    :input => %[Al| d *],
  },

  {
    :title => "類型: 水色や紫を左端に(20G)",
    :author => "いぺぱぴ",
    :date => "2000-07-20",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0007.html#000720",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "p",
    :field => <<-EOT,
    y...yy....
    yy..yy....
    yy.yyyyyy.
    yyyyyyyyy.
    EOT
    :input => %[l| Bl d *],
  },

  {
    :title => "前回の議論:水色が来たらはまる形！",
    :author => "いぺぱぴ",
    :date => "2000-07-19",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0007.html#000719",
    :difficulty => nil,
    :comment => "５列目愛護委員会員なので緑を6-8",
    :controller => SimulateController.new,
    :pattern => "opgc",
    :field => <<-EOT,
    ..........
    ..........
    ..g..g....
    .gggggggg.
    ggggggggg.
    ggggggggg.
    EOT
    :input => <<-EOT,
    * A d
    A* r . r d
    * r . r . d
    Al| d *
    EOT
  },

  {
    :title => "瞬間三回転＆シンクロ逆上がり",
    :author => "いぺぱぴ",
    :date => "2000-07-19",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0007.html#000719",
    :difficulty => 4.5,
    :comment => "右ため、IRS-A、(出現)、C、(右端に届いたら)←+A",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    ....c.....
    ...cccc...
    c.cccc....
    ccccccc...
    ccccccc...
    cccccccc..
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[Ar* Cr| Al d *],
  },

  {
    :title => "ぬりかべ",
    :author => "いぺぱぴ",
    :date => "2000-08-31",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0008.html#000831",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "c",
    :field => <<-EOT,
    bbbb.......
    bbb........
    bbbb.......
    bbbbb......
    EOT
    :input => %[A* B . B d *],
  },

  {
    :title => "水色の置き場所は？(20G)",
    :author => "いぺぱぴ",
    :date => "2000-09-30",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0009.html#000930",
    :difficulty => nil,
    :comment => "9通りの方法がある",
    :controller => SimulateController.new,
    :pattern => "cp",
    :field => <<-EOT,
    ....r.....
    ....r.....
    ..rrrrr...
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    EOT
    :input => <<-EOT,
    A* r C d
    Br| d *
    EOT
  },

  {
    :title => "緑の操作は(20G)",
    :author => "いぺぱぴ",
    :date => "2000-10-11",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0010.html#001011",
    :difficulty => 1.5,
    :comment => "右、Ａ、Ｂ、下",
    :controller => SimulateController.new,
    :pattern => "g",
    :field => <<-EOT,
    ..ccc.....
    c.ccc.....
    cccccc....
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[* r A B d *],
  },

  {
    :title => "青も同様に(20G)",
    :author => "いぺぱぴ",
    :date => "2000-10-11",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0010.html#001011",
    :difficulty => 1.5,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ....c.....
    ...cc.....
    c.ccccc...
    cccccccc..
    ccccccccc.
    EOT
    :input => %[* r A B d *],
  },

  {
    :title => "同時押し可能！？",
    :author => "いぺぱぴ",
    :date => "2000-10-11",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0010.html#001011",
    :difficulty => 1.5,
    :comment => "ＡとＢの同時押しをすると、（１回転目で）蹴れる壁があるとブロックは壁を蹴って横にずれる",
    :controller => SimulateController.new,
    :pattern => "p",
    :field => <<-EOT,
    ...cc.....
    ...cc.....
    cccccc....
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[* r A B d *],
  },

  {
    :title => "Lv900台ではシンプルに配置",
    :author => "いぺぱぴ",
    :date => "2000-11-29",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0011.html#001129",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    ....c.....
    ....cc....
    ...cccccc.
    ..ccccccc.
    .cccccccc.
    .cccccccc.
    .cccccccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[Ar| d *],
  },

  {
    :title => "３連続シンクロ",
    :author => "いぺぱぴ",
    :date => "2000-11-29",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0011.html#001129",
    :difficulty => 5,
    :comment => "１回目のシンクロは実用上意味がある場合が稀にある",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    .....c.c.c
    .....c.c.c
    .....c.ccc
    EOT
    :input => %[* 15 Ar .15 Br .15 Ar .15 r d *],
  },

  {
    :title => "実用可能なオレンジシンクロ",
    :author => "いぺぱぴ",
    :date => "2000-11-29",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0011.html#001129",
    :difficulty => 4.5,
    :comment => "左の窪みにオレンジを入れるにはシンクロしかない",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    c.........
    cc.c......
    cc.c..c...
    cccc.cccc.
    ccccccccc.
    ccccccccc.
    EOT
    :input => %[* Bl . l d *],
  },

  {
    :title => "サドンデス例1",
    :author => "いぺぱぴ",
    :date => "2000-12-16",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0012.html#001216",
    :difficulty => nil,
    :comment => "コンコンが反動して7列目に赤が立つと死",
    :controller => SimulateController.new,
    :pattern => "ro",
    :field => <<-EOT,
    ...c......
    ccccccc...
    ccccccc...
    ccccccc...
    ccccccc.c.
    ccccccc.c.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    EOT
  },

  {
    :title => "サドンデス例2",
    :author => "いぺぱぴ",
    :date => "2000-12-16",
    :url => "http://homepage3.nifty.com/tgm/boyakilog0012.html#001216",
    :difficulty => nil,
    :comment => "コンコンが反動して4-5列目に緑が立つと即死",
    :controller => SimulateController.new,
    :pattern => "gy",
    :field => <<-EOT,
    ...c......
    ..cc......
    c.ccccc...
    cccccccc..
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
    ccccccccc.
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
