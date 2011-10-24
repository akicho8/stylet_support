#!/usr/local/bin/ruby -Ku


require "world_rule_mino_controll_optimize"

class SimulateTDSWiki2Controller < SimulateDSController
  include TDSWikiModule

  attr_accessor :lr_moved_snapshot

  def initialize(*)
    super
    @wall_collision = nil
    @lr_moved_snapshot = false
    @tetris_field_default_size = "8px"
  end

  # テトリミノをセットした最初の状態
  def mino_set_signal(player)
    super
    field_snapshot(player.current_mino, "#{player.current_mino.to_s(:nickname)}登場")
    @wall_collision_dir = nil
    @prev_dir = nil
  end

  # 書き込む直前
  def before_puton_signal(player)
    super
    player.current_mino.puton{
      if player.field.complate_info.empty?
        if player.next_mino
          comment = "#{player.current_mino.get_points.dir_name_jp}向きで置く"
        else
          comment = "庇を作る"
        end
      else
        comment = "#{player.current_mino.get_points.dir_name_jp}向きで置いて#{player.field.complate_info.size}ライン消去"
      end
      # player.field.complate_info
      # p complate_info
      field_snapshot(player.current_mino, comment)
    }
  end

  # ブロック消去直後
  def lines_reject_after_signal(player)
    super
    if player.next_mino.nil?
      field_snapshot(player.field, "最後にブロック消去")
    end
  end





#   # 左右に移動した後
#   def right_left_move_after_signal(mino, dir)
#     super
#     right_left = Direction.new(dir).jinspect

#     if @lr_moved_snapshot
#       comment =
#       if @prev_dir == dir
#         # 前回と同じ方向に進んだ
#         comment = "コン"
#       else
#         comment = "#{right_left}にコン"
#       end
#       field_snapshot(mino, comment)
#     end

#     status = mino.moveable?(dir)

#     # 前回壁にぶつかっていた(けどここに来たということは動いたということ)
#     if @wall_collision_dir
#       #                status
#       # |o | → | o|    true
#       # |o | → | o |   false
#       # statusはどちらでもよい
#       field_snapshot(mino, "1マス戻す")
#     end

#     unless status
#       field_snapshot(mino, "#{right_left}の壁にあてる")
#     end

#     #     if @wall_collision_dir
#     #       if status
#     #         # |o | → | o | となった場合
#     #       else
#     #         # |o | → | o| となった場合
#     #       end
#     #     else
#     #       if status
#     #         # | o | → | o | となった場合
#     #       else
#     #         # | o | → | o| となった場合
#     #       end
#     #     end

#     # その方向にさらには動けなかった = 壁にぶつかった
#     # ときの方向を保存する
#     unless status
#       @wall_collision_dir = dir
#     else
#       @wall_collision_dir = nil
#     end

#     @prev_dir = dir
#   end

#   # 回転直後
#   def rotate_after_signal(mino, dir, success)
#     super
#     return unless success

#     if false
#       right_left = (dir == Direction::TURN_LEFT) ? "左" : "右"
#       comment = "#{right_left}回転"
#     else
#       right_left = (dir == Direction::TURN_LEFT) ? "B" : "A"
#       comment = "#{right_left} ボタン"
#     end
#     field_snapshot(mino, comment)
#   end

end


class T_Spin_Patten
  include TDSWikiUtil

  def initialize(params)
    @params = params
  end

  def aname
    "tst_pattern_#{@params[:pattern]}"
  end

  def to_aname
    to_aname_by_id(aname)
  end

  def to_link
    link_to(aname)
  end

  def to_title
    colors = @params[:pattern].scan(/./)
    colors[0..1].collect{|color|
      Mino::World.create(color).to_s(:nickname)
    } * "→"
  end

  def field_data
    controller = SimulateTDSWiki2Controller.new(0)
    field = Field.new([10, 10], @params[:field])
    frame = Frame.new([field], [Player.new(field, 4, TextInputUnit.new(@params[:input]), Pattern::OriginalRec.new(@params[:pattern]), controller, Mino::World)])
    if false
      ui = UI::SimulateFrameDraw.new(frame)
      ui.set_title(@params[:pattern])
      ret = frame.start(60){Gtk.main_iteration while Gtk.events_pending?}
      ui.close
    else
      ret = frame.start
    end
    controller.wiki_article
  end


end

class T_Spin_List
  def initialize

    field1 = <<-EOS
    ..........
    xxxx...xxx
    xxxxx.xxxx
    EOS

    field1b = <<-EOS
    ..........
    xxxx...xxx
    xxxx...xxx
    xxxxx.xxxx
    EOS

    field2 = <<-EOS
    ...xx.....
    xxxx...xxx
    xxxxx..xxx
    xxxxx..xxx
    xxxxx.xxxx
    EOS

    field_tst = <<-EOS
    xxx...xxxx
    xxx...xxxx
    xxx...xxxx
    xxx...xxxx
    EOS

    field_tst_r = <<-EOS
    xxxxxx*...
    xxxxxx*...
    xxxxxx*...
    xxxxxx*...
    EOS

    field_tst_l = <<-EOS
    ...*xxxxxx
    ...*xxxxxx
    ...*xxxxxx
    ...*xxxxxx
    EOS

    field_tst2 = <<-EOS
    xxx....xxx
    xxx....xxx
    xxx....xxx
    EOS

    field_tst3 = <<-EOS
    xxxx...xxx
    xxxx...xxx
    xxxx...xxx
    xxxx...xxx
    xxxx...xxx
    xxxx...xxx
    xxxx...xxx
    EOS

    @data_list = [
      {
        :title => "1ライン消しを伴うT-Spinトリプルパターン集",
        :samples => [
          {:pattern => "ror", :input => "r| u * rL| u * r . rR u *", :field => field_tst_r},
          {:pattern => "bgr", :input => "rL| u * r| u * r . rR u *", :field => field_tst_r},
          {:pattern => "gbg", :input => "l| u * lR| u * l . lR u *", :field => field_tst_l},
          {:pattern => "org", :input => "lR| u * l| u * l . lR u *", :field => field_tst_l},
        ],
      },
    ]
#     @data_list2 = [
#       {
#         :title => "1ライン消しを伴うT-Spinトリプルパターン集",
#         :samples => [
#           {:pattern => "ror", :input => "r| u * rL| u * r . rR u *", :field => field_tst_r},
#           {:pattern => "bgr", :input => "rL| u * r| u * r . rR u *", :field => field_tst_r},
#           {:pattern => "gbg", :input => "l| u * lR| u * lR u *", :field => field_tst_l},
#           {:pattern => "org", :input => "lR| u * l| u * lR u *", :field => field_tst_l},
#         ],
#       },
#     ]

#       {
#         :title => "最速 T-Spin トリプル",
#         :samples => [
#           {:pattern => "pog", :input => "*   u *   R . R u * r . rR u *", :field => field_tst2},
#           {:pattern => "pbr", :input => "* r u * r L . L u *     lL u *", :field => field_tst2},
#           {:pattern => "bpg", :input => "*   u *   R . R u * r . rR u *", :field => field_tst2},
#           {:pattern => "opr", :input => "* r u * r L . L u *     lL u *", :field => field_tst2},
#         ],
#       },
#       {
#         :title => "Back to Back T-Spin トリプル",
#         :samples => [
#           {:pattern => "yrb", :input => "* u * R u * R u *", :field => field_tst3},
#         ],
#       },





#       {
#         :title => "1手",
#         :samples => [
#           {:pattern => "y", :input => "* l u *", :field => field1},
#           {:pattern => "c", :input => "* l| r u *", :field => field1},
#           {:pattern => "g", :input => "* L u *", :field => field1b},
#           {:pattern => "y", :input => "* r u *", :field => field2},
#         ],
#       },
#       {
#         :title => "2手",
#         :samples => [
#           {:pattern => "y", :input => "* l u *", :field => field2},
#         ],
#       },

  end

  def to_wiki_article
    out = ""
    @data_list.each{|hash_data|
      out << "** #{hash_data[:title]} &new(nodate){#{Date.today}};\n"
out << "
24スレの>>20,78,79,85が元ネタです。というより、その簡単なまとめみたいなものです。

// なるべく同じ条件で、たくさんのパターンが組めることを示したかったので、あえてフィールドの初期状態を同じものとしています。

要点
- コの字のくぼみができる方向に注意します。
- 庇の土台の組み方は自由ですが、慣れないうちは、水色(I型)を立てて使う、と決めておくと組みやすくなります。
- フィールド図のように赤色(Z型)か緑色(S型)で庇を作るときは、かわりとして紫色(T型)も使えます。
- 赤色(Z型)か緑色(S型)が初手の場合、かわりとして紫色(T型)も使えます。

対戦で使う場合は、より柔軟な対応ができるように、なるべく□ブロックの方から先に積んでいき、6〜8割ほど綺麗に積んで、いけそうだと確信したら、コの字の方に着手し、最後に庇を作ります。順番が逆だとほとんど自滅します。局面に合わせて「いつでも諦められるように積む」のが重要です。


// |パターン|庇の方向|
// |赤色(Z型)→橙色(L型)|左|
// |青色(J型)→緑色(S型)|左|
// |緑色(S型)→青色(J型)|右|
// |橙色(L型)→赤色(Z型)|右|

#br
"
      out << "\n"
      hash_data[:samples].each_with_index{|hash_one, index|
        one = T_Spin_Patten.new(hash_one)
        out << "#{one.to_aname} SIZE(12){''#{index.succ}. #{one.to_title}''}\n"
        out << "\n"
        out << one.field_data
        if index >= 0
          out << "#br\n"
        end
        out << "\n"
      }
      out << ""
    }
    TDSWikiUtil.filter(out)
    out
  end
end

# Simulator.start(library[0], 60)
# Simulator.start_auto(library[0], 60)

if $0 == __FILE__
  fname = Pathname("t_spin.txt").expand_path
  obj = T_Spin_List.new
  fname.open("w"){|f|f << obj.to_wiki_article.toutf8}
  puts "write: #{fname}"
  # puts obj.inspect
end
