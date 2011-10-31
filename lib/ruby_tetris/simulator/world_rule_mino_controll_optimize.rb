#!/usr/local/bin/ruby -Ku


require "classic_mino_optimize"

class String
  def operation_reverse
    self.tr("AB右左", "BA左右")
  end
end

module TDSWikiUtil
  def link_to(name, id)
    "[[#{name}>##{id}]]"
  end

  def to_aname_by_id(id)
    "&aname(#{id});"
  end

  def filter(str)
    str.gsub!(/^\/\/.*\n/, "")      # コメント削除
    str.gsub!(%r/\n\n\n+/m, "\n\n") # 連続する空行を1行に
    # str.gsub!(%r/\s+$/, "\n")       # 行末のスペース消去
    str = str.strip + "\n"          # 上下の空行を消す
  end

  module_function :filter
end

module TDSWikiModule
  def initialize(*)
    super
    @wiki_article_ary = []
    @tetris_field_default_size = "10px"
  end

  # UTF-8の場合、全角文字のサイズを 3 バイトとみなすため「バイト数 != 横幅」の関係になってしまう。
  # だから ljust や center が使えない。
  # でも euc に変換すると「バイト数 == 横幅」になるため一時的に変換している。
  def wiki_article
    line_prefix = "" # 通常 pre タグの中にいれる場合は半角スペースにする
    tetris_field{
      sync_enum = SyncEnumerator.new(*@wiki_article_ary.collect{|field1|field1.to_a})
      sync_enum.to_a.collect{|columns|
        line_prefix + columns.collect{|column|
          column.to_s.strip.toeuc.center((1 + 10 + 1) * 2).toutf8
        }.to_s + "\n"
      }.to_s
    }
  end

  def tetris_field
    "#tetris_field(#{@tetris_field_default_size}){{\n#{yield}}}\n"
  end

  def field_snapshot(mino, comment = nil)
    str = ""
    if mino.kind_of?(Field)
      str << mino.to_s(:style => "wiki", :top => 1)
    else
      mino.puton{
        str << mino.field.to_s(:style => "wiki", :top => 1)
      }
    end
    str << "#{comment}\n" if comment
    @wiki_article_ary << str
  end

end

class SimulateTDSWikiController < SimulateDSController
  include TDSWikiModule

  attr_accessor :lr_moved_snapshot

  def initialize(*)
    super
    @wall_collision = nil
    @lr_moved_snapshot = false
  end

  # テトリミノをセットした最初の状態
  def mino_set_signal(player)
    super
    field_snapshot(player.current_mino, "スタート")
    @wall_collision_dir = nil
    @prev_dir = nil
  end

  # 左右に移動した後
  def right_left_move_after_signal(mino, dir)
    super
    right_left = Direction.new(dir).jinspect

    if @lr_moved_snapshot
      comment =
      if @prev_dir == dir
        # 前回と同じ方向に進んだ
        comment = "コン"
      else
        comment = "#{right_left}にコン"
      end
      field_snapshot(mino, comment)
    end

    status = mino.moveable?(dir)

    # 前回壁にぶつかっていた(けどここに来たということは動いたということ)
    if @wall_collision_dir
      #                status
      # |o | → | o|    true
      # |o | → | o |   false
      # statusはどちらでもよい
      field_snapshot(mino, "1マス戻す")
    end

    unless status
      field_snapshot(mino, "#{right_left}の壁にあてる")
    end

    #     if @wall_collision_dir
    #       if status
    #         # |o | → | o | となった場合
    #       else
    #         # |o | → | o| となった場合
    #       end
    #     else
    #       if status
    #         # | o | → | o | となった場合
    #       else
    #         # | o | → | o| となった場合
    #       end
    #     end

    # その方向にさらには動けなかった = 壁にぶつかった
    # ときの方向を保存する
    unless status
      @wall_collision_dir = dir
    else
      @wall_collision_dir = nil
    end

    @prev_dir = dir
  end

  # 回転直後
  def rotate_after_signal(mino, dir, success)
    super
    return unless success

    if false
      right_left = (dir == Direction::TURN_LEFT) ? "左" : "右"
      comment = "#{right_left}回転"
    else
      right_left = (dir == Direction::TURN_LEFT) ? "B" : "A"
      comment = "#{right_left} ボタン"
    end
    field_snapshot(mino, comment)
  end
end

module TDSWikiTetromino
  include TDSWikiUtil

  def to_link(options = {})
    options = {}.merge(options)
    params = [self.color]
    case options[:with]
    when :dir
      params += [self.get_points.dir_name]
    when :column
      params += [self.get_points.dir_name, self.to_column]
    else
      if options[:operation_key]
        params += [self.get_points.dir_name, self.to_column, options[:operation_key]]
      end
    end
    params.compact * "_"
  end

  # テトリミノのx座標を中央からの相対座標として人間に読みやすい形で返す
  # "left4" "right1" "center" など
  def to_column(options = {})
    options = {
      :left => "left",
      :right => "right",
      :center => "center",
      :end => "_end",
    }.merge(options)
    gap = self.x - 4
    if gap.zero?
      options[:center]
    elsif !self.moveable?(Point::LEFT)
      "#{options[:left]}#{options[:end]}"
    elsif !self.moveable?(Point::RIGHT)
      "#{options[:right]}#{options[:end]}"
    elsif gap < 0
      "#{options[:left]}#{gap.abs}"
    else
      "#{options[:right]}#{gap.abs}"
    end
  end

  def to_column_ja
    to_column(:left => "左", :right => "右", :center => "中央", :end => "端")
  end

  def to_dir_ja
    "#{self.get_points.dir_name_jp}向き"
  end

  def to_title
    "#{to_nickname} #{to_dir_ja} #{to_column_ja}"
  end

  def to_topic_path_title
    [
      link_to(to_nickname, to_link),
      link_to(to_dir_ja, to_link(:with => :dir)),
      "&aname(#{to_link(:with => :column)});",
      self.to_column_ja,
    ] * " "
  end

end

class WorldRuleBlockControllOptimize < ClassicBlockControllOptimize
  # "折り返してからの裏返しでは、どちらのボタンを使ったらよいか気する必要がありません。しかしタイミングを誤って、面の広い方を壁にぶつけてしまうと、1列ずれるミスを誘発します。なので、どちらかといえば例1を使った方がよいでしょう。"

  def initialize(*)
    super

    @unique_controll_minos = %w(T S I O)

    @categories = [
      [:near,     "左右移動しない"],
      [:tap,      "横に一つ動かす"],
      [:taptap,   "コンコン"],
      [:wall,     "壁にあてる"],
      [:reaction, "折り返し"],
    ]

    o_com1l = "裏返しのタイミングは自由です。また、どちらのボタンを使ってもかまいません。ただ、基本的には、壁際と折り返しの二択がやりやすいように、なるべく B ボタンだけを使う例1の方がよいでしょう。"
    o_com1r = o_com1l.operation_reverse

    # o_com_xl = "折り返してから裏返しでは、どちらのボタンを使っても位置が同じになる、という当たり前の法則があります。万が一、例1の方法でボタンの選択に迷ったときは、その法則を思い出して、正確に折り返してからボタン2連打で凡ミスを防ぎます。通常は、B ボタンを使う例1の方法を念頭に置いておきます。"

    o_com2l = "折り返してからの裏返しでは、どちらのボタンを使っても位置が同じになります。どちらのボタンを使うべきか考えなくてよいので、操作が簡単になるという利点があります。しかし、この簡単な操作に慣れてしまうと、乱暴な操作がミスを誘発します。
というのも気が焦ってより速く操作しようとするあまり、壁にぶつける前に1回転させてしまい、それがもし A ボタンを使っていた場合、面の広い方が壁に当たります。すると折り返したつもりが壁際から離れていないというミスが起きます。どんなに激しい操作でもミスが起きないように、基本は《左端からの折り返しは B ボタンで反転》を念頭に例1の方法を使うようにします。

"
# ならば例2の方法は不要ではないか、と言われるかもしれませんが、万が一、例1の操作でボタンの選択に迷いが生じたときは、安全策として、例2の方法を思い出して実践します。落ち着いて、正確に折り返し、任意のボタンを2連打で、凡ミスを回避します。
# 何度も書いてしまいますが、通常は例1のように B ボタンのみを使うようにします。

    o_com2r = o_com2l.operation_reverse

    o_com3l = "壁際と折り返しの二択がやりやすいように B ボタンで回転します。裏返しのタイミングは自由です。この例では余裕をもって2回転させるために、壁にぶつける前に1回転しています。"
    o_com3r = o_com3l.operation_reverse

    o_com4l = "B ボタンを使っていれば回転のタイミングは自由です。A ボタンを使ってしまうと面の広い方が壁に当たって1列ずれるミスを誘発します。なので、どのタイミングで回転させても折り返しが確実に決まるように B ボタンを使うようにします。この例では余裕をもって2回転させるために、壁にぶつける前に1回転しています。"
    o_com4r = o_com4l.operation_reverse

    o_com5T = "移動中に素早く回転させます。回転のタイミングが遅すぎると、移動中にいったん停止してしまい、時間のロスが生まれるので、移動開始と同じぐらいのタイミングで早めに回転を済ませます。"
    o_com5I = o_com5T + "また焦って1列手前に立ててしまわないように、とくに大事な局面では、若干長めに、壁に押し当てるような感覚で、丁寧に操作します。"

    o_com6 = "あてる前に回転すると列がずれるので、慣れるまでは回転ボタンを押すタイミングを少し遅らせるような感じで操作します。"
    o_com7 = "あてる前に回転してもかまいません。"
    o_com8 = "あてる前に回転してもかまいません。"

    # 単純そうに見えて一番難しいのがこの操作です。なぜならワールドルールの回転法則の癖に一番影響されやすいからです。
    comment_proc_A_comment = proc{|mino|
      "簡単そうに見えて難しいのがこの操作です。クラシックルールの回転法則に慣れていると、B ボタンを押しながら右に1つ移動という迂遠な操作、もしくは A ボタンを押しながら右に1つ移動して1マス行き過ぎてしまうという操作ミスをしてしまいがちです。とくに前者はやっかいで、クラシックルールの回転法則では最適な操作の一つであるため、それほど違和感を感じないこともあります。 たとえ気づいて一時、治したとしてもしたとしても、無意識のうちに元の冗長な操作に戻っていたりします。ワールドルールでは頭を切り替えて、A ボタン一発で右にずれるテトリミノをしっかりとイメージします。"
}

    comment_proc_A = lambda{|mino|
      case mino.shape_char.upcase
      when "S"
        comment_proc_A_comment.call(mino)
      end
    }

    comment_proc_B = lambda{|mino|
      case mino.shape_char.upcase
      when "Z"
        comment_proc_A_comment.call(mino).operation_reverse
      end
    }

    @operations = {
      "lR"    => {:input => "*  l    R", :title => "左に1つ移動しながら A ボタン", :category_id => :tap, :ctype => :easy},
      "R"     => {:input => "*       R", :title => "A ボタンのみ", :comment => comment_proc_A, :category_id => :near, :ctype => :easy},
      "rR"    => {:input => "* r     R", :title => "右に1つ移動しながら A ボタン", :category_id => :tap, :ctype => :easy},
      "rrR"   => {:input => "* r . r R", :title => "右にコンコンしながら A ボタン", :category_id => :taptap, :ctype => :easy},
      "lL"    => {:input => "*  l    L", :title => "左に1つ移動しながら B ボタン", :category_id => :tap, :ctype => :easy},
      "L"     => {:input => "*       L", :title => "B ボタンのみ", :comment => comment_proc_B, :category_id => :near, :ctype => :easy},
      "rL"    => {:input => "* r     L", :title => "右に1つ移動しながら B ボタン", :category_id => :tap, :ctype => :easy},
      "rrL"   => {:input => "* r . r L", :title => "右にコンコンしながら B ボタン", :category_id => :taptap, :ctype => :easy},
      "lLL"   => {:input => "* l     L . L", :title => "左に1つ移動しながら裏返し", :comment => "裏返すタイミングは自由です。", :category_id => :tap, :ctype => :easy},
      "LL"    => {:input => "*       L . L", :title => "裏返し", :comment => "裏返すタイミングは自由です。", :category_id => :near, :ctype => :easy},
      "rRR"   => {:input => "* r     R . R", :title => "右に1つ移動しながら裏返し", :comment => "裏返すタイミングは自由です。", :category_id => :tap, :ctype => :easy},
      "rRrR"  => {:input => "* r . R . r . R", :title => "右にコンコンしながら裏返し", :comment => "裏返すタイミングは自由です。", :category_id => :taptap, :ctype => :easy},
      "lLlL"  => {:input => "* l . L . l . L", :title => "左にコンコンしながら裏返し", :comment => "裏返すタイミングは自由です。", :category_id => :taptap, :ctype => :easy},
      "l"     => {:input => "* l", :title => "左に1つ移動", :category_id => :tap, :ctype => :easy},
      "nop"   => {:input => "*", :title => "その場で落とす", :category_id => :near, :ctype => :easy},
      "r"     => {:input => "* r", :title => "右に1つ移動", :category_id => :tap, :ctype => :easy},
      "rr"    => {:input => "* r . r", :title => "右にコンコン", :category_id => :taptap, :ctype => :easy},
      "llR"   => {:input => "* l . l R", :title => "左にコンコンしながら A ボタン", :comment => "", :category_id => :taptap, :ctype => :easy},
      "llL"   => {:input => "* l . l L", :title => "左にコンコンしながら B ボタン", :category_id => :taptap, :ctype => :easy},

      # 次の2つはI専用
      "Ll_"   => {:input => "* Ll|", :title => "左の壁にあてる前に、B ボタン", :comment => o_com5I, :category_id => :wall, :ctype => :easy},
      "Rr_"   => {:input => "* Rr|", :title => "右の壁にあてる前に、A ボタン", :comment => o_com5I, :category_id => :wall, :ctype => :easy},

      # 次の2つはTJL専用
      "Lr_"   => {:input => "* Lr|", :title => "右の壁にあてる前に、B ボタン", :comment => o_com5T, :category_id => :wall, :ctype => :hard},
      "Rl_"   => {:input => "* Rl|", :title => "左の壁にあてる前に、A ボタン", :comment => o_com5T, :category_id => :wall, :ctype => :hard},

      "must_l_R"   => {:input => "l|  R", :title => "左の壁にあてた後、 A ボタン", :comment => o_com6, :category_id => :wall, :ctype => :hard},
      "must_l_L"   => {:input => "l|  L", :title => "左の壁にあてた後、 B ボタン", :comment => o_com6, :category_id => :wall, :ctype => :hard},
      "must_r_R"   => {:input => "r|  R", :title => "右の壁にあてた後、 A ボタン", :comment => o_com6, :category_id => :wall, :ctype => :hard},
      "must_r_L"   => {:input => "r|  L", :title => "右の壁にあてた後、 B ボタン", :comment => o_com6, :category_id => :wall, :ctype => :hard},


      "l_rR"  => {:input => "l| r    R", :title => "左の壁で折り返した後、 A ボタン", :category_id => :reaction, :ctype => :hard},

      "l_rL"  => {:input => "l| r L", :title => "左の壁で折り返しながら B ボタン", :comment => o_com8, :category_id => :reaction, :ctype => :easy},
      "r_lR"  => {:input => "r| l R", :title => "右の壁で折り返しながら A ボタン", :comment => o_com8, :category_id => :reaction, :ctype => :easy},

      "must_r_lL"  => {:input => "r| l    L", :title => "右の壁で折り返した後、 B ボタン", :comment => o_com6, :category_id => :reaction, :ctype => :hard},

      # 壁際のぶつけてから裏返す お勧めしない方法
      "l_LL"  => {:input => "l|      L . L", :title => "左の壁にあてて裏返し", :comment => o_com1l, :category_id => :wall, :ctype => :easy},
      "r_RR"  => {:input => "r|      R . R", :title => "右の壁にあてて裏返し", :comment => o_com1r, :category_id => :wall, :ctype => :easy},

      # 端から1つ内側 お勧めしない
      "must_l_rLL" => {:input => "l| r  L . L", :title => "左の壁で折り返してから裏返し", :comment => o_com2l, :category_id => :reaction, :ctype => :easy},
      "must_r_lRR" => {:input => "r| l  R . R", :title => "右の壁で折り返してから裏返し", :comment => o_com2r, :category_id => :reaction, :ctype => :easy},

      # 端から一つ内側 おすすめパターン
      "Ll_rL" => {:input => "* L l|  r   L", :title => "左の壁にあてる前に B ボタン、折り返すと同時に B ボタン", :comment => o_com4l, :category_id => :reaction, :ctype => :hard2},
      "Rr_lR" => {:input => "* R r|  l   R", :title => "右の壁にあてる前に A ボタン、折り返すと同時に A ボタン", :comment => o_com4r, :category_id => :reaction, :ctype => :hard2},

      # 端 おすすめ
      "must_Ll_L"  => {:input => "* L l| L", :title => "左の壁にあてる前に B ボタン、あたってから B ボタン", :comment => o_com3l, :category_id => :wall, :ctype => :hard},
      "must_Rr_R"  => {:input => "* R r| R", :title => "右の壁にあてる前に A ボタン、あたってから A ボタン", :comment => o_com3r, :category_id => :wall, :ctype => :hard},



      "l_"    => {:input => "l|", :title => "左の壁にあてる", :category_id => :wall, :ctype => :easy},
      "l_r"   => {:input => "l| r", :title => "左の壁で折り返す", :category_id => :reaction, :ctype => :easy},
      "r_l"   => {:input => "r| l", :title => "右の壁で折り返す", :category_id => :reaction, :ctype => :easy},
      "r_"    => {:input => "r|", :title => "右の壁にあてる", :category_id => :wall, :ctype => :easy},

      "ll"    => {:input => "* l . l", :title => "左にコンコン", :category_id => :taptap, :ctype => :easy},

      "l_L"   => {:input => "l|   L", :title => "左の壁にあてて B ボタン", :comment => o_com7, :category_id => :wall, :ctype => :easy},
      "r_R"   => {:input => "r|   R", :title => "右の壁にあてて A ボタン", :comment => o_com7, :category_id => :wall, :ctype => :easy},
    }

    @purple_down = {
      :advice => "",
      :dir => "down",
      :column_operations => [
        [1,"l_"],
        [2,"l_r", "ll"],  # tricky
        [3,"l"],
        [4,"nop"],
        [5,"r"],
        [6,"rr"],
        [7,"r_l"],
        [8,"r_"],
      ],
    }

    @purple_dir_operations = [
      @purple_down,
      {
        :advice => "",
        :dir => "left",
        :column_operations => [
          [0,"Rl_"],
          [1,"must_l_R"],
          [2,"l_rR","llR"],     # tricky
          [3,"lR"],
          [4,"R"],
          [5,"rR"],
          [6,"rrR"],
          [7,"r_lR"],           # 紫(T型) 右3
          [8,"r_R"],
        ],
      },
      {
        :advice => "左2や右3に置く方法は間違えやすいので、回転方向に注意し、面の広い方を壁にあてないようにします。左2の場合のみコンコンの方法もあります。",
        :dir => "up",           # 裏返し
        :column_operations => [
          [1,"must_Ll_L", "l_LL"],
          [2,"Ll_rL","must_l_rLL","lLlL"], # tricky
          [3,"lLL"],
          [4,"LL"],
          [5,"rRR"],
          [6,"rRrR"],
          [7,"Rr_lR","must_r_lRR"],
          [8,"must_Rr_R", "r_RR"],
        ],
      },
      {
        :advice => "",
        :dir => "right",
        :column_operations => [
          [1,"l_L"],
          [2,"l_rL","llL"],     # tricky
          [3,"lL"],
          [4,"L"],
          [5,"rL"],
          [6,"rrL"],
          [7,"must_r_lL"],
          [8,"must_r_L"],
          [9,"Lr_"],
        ],
      },
    ]

    @green_dir_operations = [
      @purple_down,
      {
        :advice => "",
        :dir => "left",
        :column_operations => [
          [0,"l_L"],
          [1,"must_l_R","llL"], # tricky
          [2,"lL"],
          [3,"L"],
          [4,"R"],
          [5,"rR"],
          [6,"must_r_lL","rrR"],# tricky
          [7,"must_r_L"],
          [8,"r_R"],
        ],
      },
    ]

    @mino_operations = [

      {
        :shape => "Yellow",
        :comment => "",
        :dir_operations => [
          {
            :advice => "",
            :dir => "down",
            :column_operations => [
              [0,"l_"],
              [1,"l_r"],
              [2,"ll"],
              [3,"l"],
              [4,"nop"],
              [5,"r"],
              [6,"rr"],
              [7,"r_l"],
              [8,"r_"],
            ],
          },
        ],
      },

      {
        :shape => "Cyan",
        :comment => "",
        :dir_operations => [
          {
            :advice => "",
            :dir => "down",
            :column_operations => [
              [1,"l_"],
              [2,"l_r","ll"],   # tricky
              [3,"l"],
              [4,"nop"],
              [5,"r"],
              [6,"r_l","rr"],   # tricky
              [7,"r_"],
            ],
          },
          {
            :advice => "ボタンの使い分けが重要。左端に立てるときは B ボタン、右端に立てるときは A ボタンを使うと1マス分の移動時間を短縮できます。",
            :dir => "left",
            :column_operations => [
              [-1,"Ll_"],
              [0,"must_l_L"],
              [1,"must_l_R","llL"], # tricky
              [2,"lL"],
              [3,"L"],
              [4,"R"],
              [5,"rR"],
              [6,"must_r_L","rrR"], # tricky
              [7,"must_r_R"],
              [8,"Rr_"],
            ],
          },
        ],
      },

      {
        :shape => "Green",
        :comment => "",
        :dir_operations => @green_dir_operations,
      },

      {
        :shape => "Red",
        :comment => "",
        :dir_operations => @green_dir_operations,
      },

      {
        :shape => "Purple",
        :comment => "",
        :dir_operations => @purple_dir_operations,
      },

      {
        :shape => "Blue",
        :comment => "",
        :dir_operations => @purple_dir_operations,
      },

      {
        :shape => "Orange",
        :comment => "",
        :dir_operations => @purple_dir_operations,
      },

    ]
  end

  def make_data_ary
    controller = SimulateDSController.new(0.008)   # 2秒間に一段落下のスピード
    #    controller.level_info.fall_delay = nil # フィールドへの書き込み禁止
    data = []
    @mino_operations.each{|mino_operation|
      shape = mino_operation[:shape]
      dir_operations = mino_operation[:dir_operations]
      dir_operations.each{|dir_operation|
        dir_operation[:column_operations].each{|column_operation, *operation_keys|
          xpos = %r/..([+-]?\d+)/.match(column_operation).captures.first.to_i
          operation_keys.each{|operation_key|
            mino = mino_create(shape)
            mino.x = xpos
            mino.dir.set(dir)
            operation = @operations[operation_key]
            data << {
              :title => "#{mino.jcolor}色を#{mino.dir.jinspect}向きで#{OptimizeHelper.mino_width(mino).collect{|i|i.succ} * ","}列目",
              :date => "2006-05-15",
              :difficulty => OptimizeHelper.to_difficulty_level_from_input_string(input),
              :comment => operation[:comment],
              :controller => controller,
              :pattern => shape,
              :field => OptimizeHelper.make_hole_field(mino),
              :input => operation[:input] + " u_ *",
              :mino_factory => Mino::World,
            }
          }
        }
      }
    }
    data
  end

  def mino_create(shape)
    mino = Mino::World.create(shape)
    mino.extend(TDSWikiTetromino)
    mino.attach(Field.new([10,10]))
    mino
  end

  def wiki_header
    "
//* はじめに
//
//テトリミノ操作最適化をマスターすると次の利点があります。
//
//+ 高速な操作が可能になる。
//+ 操作ミスを減らせる。
//+ 思考をテトリミノ操作から解放できる。
//+ 一定のピッチで積める。
//+ ゴースト不要。
//+ レーティングが向上する
//+ テトリスがもっと楽しくなる。
//
//だからって、いちいち最適化なんて難しいこと考えてやってたらつまんない
//し、もっと気楽にやればいいじゃんか、と思う一方で、無駄に高いレベルを
//目指すのも馬鹿馬鹿しくておもしろいんじゃないかと思います。

* 目次

#contents

* リファレンスを読む前に
- Aボタンは「右回転」、Bボタンは「左回転」と読み変えてもかまいません。
- 「裏返し」はとくに指定がない場合「A か B ボタンのどちらかを2回押す」と読み変えてください。
フィールド図では一方のボタンしか使っていないので、自分に合った方のボタンで裏返してください。
//- カラム位置は左端を1、右端を10としています。
- ハードドロップ操作は省略しています。適宜補完してください。
- テトリミノの向き・状態は見た目の印象で表わしています。
-- 青色(J型)・橙色(L型)の場合は、鉄砲に見たてたときの銃口の向き。
-- 紫色(T型)の場合は、中央のでっぱりが指す方向。
-- 水色(I型)・赤色(Z型)・緑色(S型)の場合は「縦」か「横」。
-- 黄色(O型)は便宜上「前」。
//- 操作例は、アーケード用のテトリスの操作方法とは異なる個所が多くあります。理由は次の3つです。出現する前に溜めを作れないこと。横移動が極端に遅いこと。十時レバーは反動が一切おきないこと。率直にいうと折り返しよりコンコンを多用した方が速いということです。とはいっても、さすがに3連続の横入れになるコンコンコンは一切載せていませんが、もしかすると折り返しよりも有利なケースがあるのかもしれません。
//- 操作例は、一番速く操作できると判断したものから優先して載せています。
//でも、あくまで参考程度にして、もっと優れた操作はないか模索してみてください。自分のやりやすい方法が一番です。~
//- 操作例は、アーケード用のテトリスの操作方法とは異なる個所が多くあります。理由は次の3つです。出現する前に溜めを作れないこと。横移動が極端に遅いこと。十時レバーは反動が一切おきないこと。率直にいうと折り返しよりコンコンを多用した方が速いということです。とはいっても、さすがに3連続の横入れになるコンコンコンは一切載せていませんが、もしかすると折り返しよりも有利なケースがあるのかもしれません。
- 操作例のなかに折り返す方法とコンコンする方法を両方含む場合は、折り返す方法を先に、コンコンする方法を後に載せています。~
たとえば「紫色(T型) 上向き 左2」では [[ 例1 >#purple_up_left2_l_r]] が折り返す方法で、 [[ 例2 >#purple_up_left2_ll]] がコンコンする方法になっています。直前にフィールドを消して溜めが可能なときは折り返しの方法を使い、そうでないときはコンコンの方法を使うなど、状況に合わせて使い分けるのがよいかもしれません。
- 操作例はあくまで参考程度にして、もっと優れた操作はないか模索してみてください。自分のやりやすい方法が一番です。~

* 予備知識

- [[紫色(T型)>#purple]]・[[青色(J型)>#blue]]・[[橙色(L型)>#orange]]の3種類は同じ操作が可能。
- [[緑色(S型)>#green]]・[[赤色(Z型)>#red]]の2種類は操作が完全に同一。
- [[紫色(T型)>#purple]]・[[青色(J型)>#blue]]・[[橙色(L型)>#orange]]・[[緑色(S型)>#green]]・[[赤色(Z型)>#red]]は初期状態だけ、操作が完全に同一。共通点は横幅が3マス。
- フィールドを消したときに溜めが可能。出現前に溜めておけるので、出現直後のテトリミノを最速で端まで移動させることができる。

//- 禁じ手
//-- 折り返して2マス以上進む操作。~
//折り返して2マス以上進むのであればコンコンした方が確実に近いし速い。
//-- 3連続で横を押すコンコンコン操作。~
//コンコンするのは名前の通り2マスまで。3連続で横を押すよりは折り返した方が総合的に有利だろうと判断した。

//* 折り返しとコンコンのメリット・デメリット
//
//主観的な思い込みな部分も多いので役に立たないかもしれません。
//
//>折り返し
//
//-- メリット
//
//--- 左親指が左右に適度な動きをするのでリズムを崩さない。~
////ミスを減らすには一定のピッチで操作することが重要。
////一時の高速化より、リズムに合わせて一定のピッチで操作することの方が重要。
//--- あまりないケースだが、判断ミスで逆方向に移動したあとでも、折り返すという抽象化された操作が多いぶん、逆方向の意図した位置に復帰しやすい。
//
//-- デメリット
//
//--- 移動距離が長くなるため時間がかかる。~
//溜めて横移動しているときでも1つ移動するごとにかなりのウェイトが入る。だから壁に当てて折り返すような長距離移動を行うと時間がかかる。
//
//>コンコン
//
//-- メリット
//
//--- 最短距離で移動できるため、慣れると最速の操作が可能になる。
//--- 自然にテトリミノを運べるので視覚的にもわかりやすい。
//--- いくらコンコンしても十時ボタンのおかげで反動がおきない。
//
//-- デメリット
//
//--- 速度自制しないと、かぶりぎみの動作で、まれにミスが起きる。~
//たとえばピアノで同じ鍵を連打する場合、同じ指だけを使うと、だんだんと指の上下運動の幅が狭まってくる。すると安定したリズムとボリュームを維持できなくなる。この悪い打鍵方法のように、速すぎるスピードで、ほとんど震動のような形で指を上下させると、ボタンを押すタイミングが崩れ、最悪、十時ボタンを押したつもりが押せていない、または押しすぎるケースがまれに起きる。

* このページで使っている用語

:コンコン|2回連続で横を押すこと。
:コン|1回だけ横を押すこと。
:折り返し|テトリミノをいったん壁にあててから反対方向に1マスだけ戻すこと。
:Aボタン|右回転のこと。
:Bボタン|左回転のこと。
:裏返し|A または B ボタンの一方を2回押すこと。2回転のこと。
:左n|左にnマス横移動したときの位置。
:右n|右にnマス横移動したときの位置。
//:反動|横に入れた反動で逆方向にも入力が入ってしまう反作用のこと。Nintendo DS の十時ボタンでは起こらない。
:溜め|テトリミノが横に連続して動き出すようになるまで、横を押しっぱなしにすること。
//:目押し|横を押しっぱなしで意図したマス分だけ移動させること。クッパの得意技。
//:瞬間裏返し|
:クラシックルール|セガ・アリカ系テトリスの流儀・回転法則のこと。
:ワールドルール|ヘンク・ロジャースが取り決めたテトリスの規約・回転法則のこと。テトリスDSの回転法則のこと。
"

  end

  # 操作方法は最小で何通りあるか？
  def operation_min_count
    used_operation_keys = []
    @mino_operations.each{|mino_operation|
      mino_operation[:dir_operations].each{|dir_operation|
        dir_operation[:column_operations].each{|xpos, *operation_keys|
          used_operation_keys << operation_keys.first
        }
      }
    }
    used_operation_keys.uniq.sort.size
  end


  # 操作方法は最大で何通りあるか？
  def operation_max_count
    used_operation_keys = []
    @mino_operations.each{|mino_operation|
      mino_operation[:dir_operations].each{|dir_operation|
        dir_operation[:column_operations].each{|xpos, *operation_keys|
          used_operation_keys += operation_keys
        }
      }
    }
    used_operation_keys
  end

  def inspect
    str = []
    str << "--------------------------------------------------------------------------------"
    str << "operation_min_count=#{operation_min_count}"
    str << "operation_max_count.size=#{operation_max_count.size}"
    str << "No use controll=#{(@operations.keys - operation_max_count).inspect}"
    str << "--------------------------------------------------------------------------------"
    str * "\n"
  end

  def mino_operations_visitor(options = {})
    options = {}.merge(options)
    @mino_operations.each{|mino_operation|
      dir_operations = mino_operation[:dir_operations]
      dir_operations.each{|dir_operation|
        shape = mino_operation[:shape]
        mino = mino_create(shape)
        if options[:only]
          next unless options[:only].include?(mino.shape_char.upcase)
        end
        mino.dir.set(dir_operation[:dir])
        dir_operation[:column_operations].each{|xpos, *operation_keys|
          mino.x = xpos
          yield mino.clone, operation_keys
        }
      }
    }
  end

  # 指定の操作に関連する操作を取得
  def relative_patterns(my_operation_key)
    relative_patterns = []
    mino_operations_visitor{|mino, operation_keys|
      operation_keys.each{|operation_key|
        if my_operation_key == operation_key
          relative_patterns << [mino, operation_key]
        end
      }
    }
    relative_patterns
  end

  # 選択肢がコンコン系のみのもの
  def taptap_only_patterns
    patterns = []
    mino_operations_visitor(:only => @unique_controll_minos){|mino, operation_keys|
      next if operation_keys.size >= 2
      operation_key = operation_keys.first
      operation = @operations[operation_key]
      if operation[:category_id] == :taptap
        patterns << [mino, operation_key]
      end
    }
    patterns
  end

  # 操作方法の選択肢に折り返し系とコンコン系の両方が含まれているテトリミノ操作一覧
  def wallback_and_taptap_include_patterns
    patterns = []
    mino_operations_visitor(:only => @unique_controll_minos){|mino, operation_keys|
      if operation_keys.size >= 2
        operation_key = operation_keys.find{|operation_key|
          operation = @operations[operation_key]
          operation[:category_id] == :taptap
        }
        if operation_key
          patterns << [mino, nil]
        end
      end
    }
    patterns
  end

  # 操作方法が難しいもの
  def difficult_patterns
    patterns = []
    mino_operations_visitor(:only => @unique_controll_minos){|mino, operation_keys|
      operation_key = operation_keys.find{|operation_key|
        operation = @operations[operation_key]
        ctype = operation[:ctype]
        [:hard, :hard2].include?(ctype)
      }
      if operation_key
        patterns << [mino, operation_key]
      end
    }
    patterns
  end


  def field_data(mino, operation_key)
    operation = @operations[operation_key]
    controller = SimulateTDSWikiController.new(0)
    if [:tap, :taptap].include?(operation[:category_id])
      controller.lr_moved_snapshot = true
    end
    field = Field.new([10, 10], OptimizeHelper.make_hole_field(mino, {:mino_factory => Mino::World, :field_color => "x"}))
    frame = Frame.new([field], [Player.new(field, 4, TextInputUnit.new(operation[:input] + " u_ *"), Pattern::OriginalRec.new(mino.color.downcase[0..0]), controller, Mino::World)])
    if false
      ui = UI::SimulateFrameDraw.new(frame)
      ui.set_title(title)
      ret = frame.start(60)
      ui.close
    else
      ret = frame.start
    end
    controller.wiki_article
  end

  def to_wiki_article
    reject_comment = "TJL型およびSZ型は操作が共通のためTS型のみ載せています。"
    out = ""
    out << wiki_header
    out << "* テトリミノ操作最適化リファレンス 索引\n"
    out << "\n"
    out << to_wiki_index
    out << to_wiki_article_reverse_index
    out << "** 選択肢がコンコン系のみの操作\n"
    out << "\n"
    out << "できるだけコンコンしたくないので、とりあえずは必須のコンコン系だけを先に覚えておきたい、という場合に見てください。#{reject_comment}\n"
    out << "\n"
    out << make_links_group_by_mino(taptap_only_patterns)
    out << "** 選択肢に折り返し系とコンコン系の両方が含まれている操作\n"
    out << "\n"
    out << "折り返し系とコンコン系ではどちらの操作が自分に合っているのか検討したい、というときなどに見てください。#{reject_comment}\n"
    out << "\n"
    out << make_links_group_by_mino(wallback_and_taptap_include_patterns)
    out << "** ミスしやすい操作\n"
    out << "\n"
    out << "時間のロスが発生しやすい操作も含んでいます。クセのある操作を復習したいときに見てください。#{reject_comment}\n"
    out << "\n"
    out << make_links_group_by_operation(difficult_patterns)
    out << to_wiki_optimize_data
    out << "* ツッコミ\n\n"
    out << "#pcomment\n\n"
    TDSWikiUtil.filter(out)
  end

  def link_to(name, id)
    "[[#{name}>##{id}]]"
  end

  def to_wiki_optimize_data
    #    controller.level_info.fall_delay = nil # フィールドへの書き込み禁止
    @data = ""
    @data << "* テトリミノ操作最適化リファレンス\n\n"

    @mino_operations.each{|mino_operation|
      shape = mino_operation[:shape]
      dir_operations = mino_operation[:dir_operations]
      mino = mino_create(shape)

      puts "mino: #{mino.color}"

      @data << "** &aname(#{mino.to_link}); #{mino.to_nickname}\n"
      @data << "\n"

      if true
        # 使いやすいように現在のテトリミノの操作へリンクを貼る
        dir_operations.each_with_index{|dir_operation, index|
          mino.dir.set(dir_operation[:dir])
          @data << "-" + link_to(mino.to_dir_ja, mino.to_link(:with => :dir)) + ":" + "\n"
          dir_operation[:column_operations].each{|xpos, *operation_keys|
            mino.x = xpos
            @data << link_to(mino.to_column_ja, mino.to_link(:with => :column)) + "\n"
          }
        }
        @data << "\n"
      end

      @data << comment_write(mino_operation[:comment])

      dir_operations.each{|dir_operation|
        dir = dir_operation[:dir]
        pp dir
        mino = mino_create(shape)
        mino.dir.set(dir)

        @data << "*** &aname(#{mino.to_link(:with => :dir)}); #{mino.to_dir_ja}\n"
        @data << "\n"

        @data << comment_write(dir_operation[:advice])

        dir_operation[:column_operations].each{|xpos, *operation_keys|

          mino.x = xpos

          @data << "#br\n"
          @data << "SIZE(16){''#{mino.to_topic_path_title}''}\n"
          @data << "\n"

          operation_keys.each_with_index{|operation_key, index|
            next unless @operations[operation_key]

            operation = @operations[operation_key]

            title = link_to("例#{index.succ}. #{operation[:title]}", "operation_#{operation_key}")

            if index >= 1
              @data << "#br\n"
            end
            @data << "> &aname(#{mino.to_link(:operation_key => operation_key)}); &size(14){#{title}};\n"
            # if mino.color == "cyan"
            @data << field_data(mino, operation_key)
            # end

            comment = operation[:comment]
            if comment.kind_of?(Proc)
              comment = comment.call(mino)
            end
            unless comment.to_s.strip.empty?
              @data << "#{comment}\n\n"
            end

            if false
              # 同じ操作をするものを取得
              relative_patterns = relative_patterns(operation_key)
              # 自分も含まれているので消す
              relative_patterns.reject!{|relative_pattern|relative_pattern == mino}
              # 表示
              unless relative_patterns.empty?
                @data << "> 同じ操作をする他の場面\n"
                @data << write_mino_links(relative_patterns)
              end
            end

            @data << ""
            @data << "\n"
          }
        }
      }
    }
    @data
  end

  def to_wiki_index
    out = ""
    out << "** テトリミノ別 索引\n"
    out << "\n"
    top_ary = []
    @mino_operations.each_with_index{|mino_operation, mino_operation_index|
      shape = mino_operation[:shape]
      dir_operations = mino_operation[:dir_operations]
      mino = mino_create(shape)
      puts "mino: #{mino.color}"
      out << ":" + link_to(mino.to_nickname, mino.to_link) + "|\n"
      dir_operations.each_with_index{|dir_operation, index|
        mino.dir.set(dir_operation[:dir])
        out << "--" + link_to(mino.to_dir_ja, mino.to_link(:with => :dir)) + ":" + "\n"
        dir_operation[:column_operations].each{|xpos, *operation_keys|
          mino.x = xpos
          out << link_to(mino.to_column_ja, mino.to_link(:with => :column)) + "\n"
        }
      }
      out << "\n"
    }
    out + "\n"
  end

  def to_wiki_article_reverse_index
    out = ""
    out << "** 操作方法別(逆引き) 索引\n"
    out << "\n"

    # 操作する種類によってグループ分けする。
    operation_groups = @operations.group_by{|operation_key, operation|operation[:category_id]}

    # ソートは @categories の順番にする。
    # @categories はもともとハッシュだったが、順番が重要なので配列にしてある
    if true
      operation_groups = operation_groups.sort_by{|v|@categories.index(@categories.assoc(v.first))}
    end

    operation_groups.each{|category_id, operation_alist|
      # データの状態
      #
      # category_id = :wall
      #
      # operation_alist = [
      # # [0]     [1][0]     [1][1]     [1][2]               # アクセス方法
      #   ["l_L", ["l|   L", "comment", :wall]],
      #   ["r_R", ["r|   R", "comment", :wall]],
      # ],
      #

      # 直リンできるように操作する種類をキーとして aname に設定する。
      out << ":&aname(category_#{category_id}); #{@categories.assoc(category_id)[1]}系|\n"

      # コメントでソート
      operation_alist.sort!{|a, b|a[1][:title] <=> b[1][:title]}

      operation_alist.each{|operation_key, operation|
        out << "-- &aname(operation_#{operation_key}); #{operation[:title]}\n"
        relative_patterns = relative_patterns(operation_key)
        out << write_mino_links(relative_patterns, :suffix => "---")
      }
    }
    out
  end

  def write_mino_links(patterns, options = {})
    out = ""
    options = {:suffix => "-", :with_operation_title => false}.merge(options)
    patterns.each{|mino, operation_key|
      title = mino.to_title
      if options[:with_operation_title]
        if operation_key
          operation = @operations[operation_key]
          title << " ─ " + operation[:title]
        end
      end
      if operation_key
        link_options = {:operation_key => operation_key}
      else
        link_options = {:with => :column}
      end
      out << options[:suffix] + " " + link_to(title, mino.to_link(link_options)) + "\n"
      # @data << field_data(mino, operation_key)
    }
    out
  end

  # 難しい操作データ用の表示
  # 操作名でグループ化して二重ループにして表示
  #
  # - 操作名1
  # -- テトリミノA
  # -- テトリミノB
  # - 操作名2
  # -- テトリミノC
  # -- テトリミノD
  #
  def make_links_group_by_operation(patterns, options = {})
    out = ""
    options = {:suffix => "--", :sort => true}.merge(options)
    hash = patterns.group_by{|mino, operation_key|operation_key}
    if options[:sort]
      # 操作方法の名前(:title)でソート
      hash = hash.sort_by{|operation_key, patterns|@operations[operation_key][:title]}
    end
    hash.each{|operation_key, patterns|
      operation = @operations[operation_key]
      out << ":#{operation[:title]}|\n"
      out << write_mino_links(patterns, :suffix => options[:suffix])
    }
    out + "\n"
  end

  # テトリミノ毎の分類してWiki用のリンクを作成
  def make_links_group_by_mino(patterns, options = {})
    out = ""
    options = {:suffix => "--", :sort => true}.merge(options)
    hash = patterns.group_by{|mino, operation_key|mino.color}
    if options[:sort]
      hash = hash.sort_by{|color, patterns|color}
    end
    hash.each{|color, patterns|
      out << ":#{mino_create(color).to_nickname}|\n"
      out << write_mino_links(patterns, :suffix => options[:suffix], :with_operation_title => true)
    }
    out + "\n"
  end

  def comment_write(comment)
    return "" if comment.to_s.empty?
    comment.to_a.collect{|e|"#{e.strip}\n\n"}.to_s
  end

  def mino_width(mino, separator="〜")
    mino_widths = OptimizeHelper.mino_width(mino)
    raise if mino_widths.empty?
    mino_widths.map!{|i|i.succ}
    if mino_widths.size == 1
      mino_widths.first.to_s
    else
      "#{mino_widths.min}#{separator}#{mino_widths.max}"
    end
  end

end

if $0 == __FILE__
  fname = Pathname("world_rule_mino_controll_optimize.txt").expand_path
  obj = WorldRuleBlockControllOptimize.new
  fname.open("w"){|f|f << obj.to_wiki_article}
  puts "write: #{fname}"
  puts obj.inspect
end
