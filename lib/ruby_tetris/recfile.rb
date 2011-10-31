#!/usr/local/bin/ruby -Ku
# リプレイデータファイル関連


begin
  require "postgres"
rescue LoadError
end

require "config"
require "load_all"
require "ui/frame"


# セクション情報管理
class RecFile

  ################################################################################
  # クラスメソッド
  ################################################################################

  # 表示
  def self.view(marshal, drawobj=UI::Sdl::Draw.instance)
    frame = Frame.replay1(marshal)
    draw_obs = UI::DrawAll.new(frame, drawobj)
    frame.safe_show
    draw_obs.close

  end

  # 再生
  def self.replay1(marshal, input_classes)
    frame = Frame.replay_with_input(marshal, input_classes)
    UI::DrawAll.new(frame)
    frame.start(60)
  end

  # リプレイ。marshal から marshal2 の間をリプレイする。
  def self.replay_a_to_b(marshal1, marshal2)
    frame = Frame.replay_a_to_b(marshal1, marshal2)
    UI::DrawAll.new(frame)
    frame.start(60)
  end

  # メソッドの場所はここじゃないな。あとで引越し予定
  def self.mpeg_convert(frame, output_mpeg, tmpdir=nil)

    # return true if File.exist?(output_mpeg)

    tmpdir = File.join(CONFIG[:snapdir], File.basename(output_mpeg, ".mpg")) unless tmpdir
    File.makedirs(tmpdir, $DEBUG)

    Dir[tmpdir+"/*"].each{|f|File.delete(f)} # 最初に中を消しておく

    begin
      # frame = Frame.replay_a_to_b(seginfo.first, seginfo.last)

      # bmpファイル生成
      disp = UI::DrawAllWithSnapShot.new(frame)
      disp.snapdir = tmpdir
      frame.start(0)

      # bmp → jpg → mpg 変換
      Tool.mpeg_convert(tmpdir, output_mpeg)
    ensure
#       Dir[tmpdir+"/*"].each{|f|File.delete(f)} # 後で消す
#       Dir.rmdir(tmpdir)
    end
  end

  def self.open(recfile, player_no=0)
    raise "File not found : '#{recfile}'" unless File.exist?(recfile)
    obj = new(Kernel.open(recfile).read, player_no)
    obj.instance_eval{
      @recfile = recfile
    }
    obj
  end

  ################################################################################
  # インスタンスメソッド
  ################################################################################

  attr_reader :recfile, :info
  attr_accessor :player_no

  def initialize(info, player_no=0)
    set_param(info, player_no)
    @recfile = nil
  end

  def set_param(info, player_no=0)
    @info = Marshal.load(info)
    @player_no = player_no
  end

  ################################################################################
  # 簡単にアクセスするためのメソッド
  ################################################################################

  # これが重要
  def seginfo
    @info[:seginfo][@player_no]
  end

  # 最後のデータは両方のプレイヤーが持っているのでプレイヤー番号はどちらでもよい
  def get_players
    field, players = Marshal.load(seginfo.last)
    players
  end

  ################################################################################
  # ここだけが info を使っている。どうにかしたい。
  ################################################################################

  def summary
    get_players.enum_with_index.collect{|player, i|
      ev = player.controller
      [
        ev.mode_name,
        ev.grade_name,
        ev.time_count,
        ev.level_count,
        ev.score_count,
        player.input.class::Name,
        "#{i+1}/#{get_players.size}",
        @info[:user],
        @info[:time].strftime("%y-%m-%d %H:%M"),
        # File.basename(@recfile, ".rec"),
        @recfile,
      ].collect{|e|e.to_s}
    }
  end

  ################################################################################
  # プレイヤーそれぞれの情報
  ################################################################################

  def sections
    prev_time_count = nil       # important
    seginfo.collect{|marshal|
      field, players = Marshal.load(marshal)
      players[@player_no].controller.instance_eval{

        table = []
        table = @delete_mino_table.last unless @delete_mino_table.empty?
        delete_mino_order = table ? table.join("") : ""

        # 他の書き方。1は標準。2,3は拡張メソッド。
        # 1. delete_mino_counts = (1..4).collect{|e|table.find_all{|i|i == e}.size}
        # 2. delete_mino_counts = (1..4).collect{|e|table.count{|i|i == e}}
        # 3. delete_mino_counts = (1..4).collect{|e|table.group_by{|x|x}[e]}
        delete_mino_counts = (1..4).collect{|e|table.count{|i|i == e}}

        prev_time_count ||= @time_count
        rap_time = count_to_timestr(@time_count - prev_time_count)
        prev_time_count = @time_count

        loss_time_str = count_to_timestr(@loss_table.last || 0)

        [
          level_count,
          time_count,
          rap_time,
          grade_name,
          delete_mino_order,
          delete_mino_counts,
          delete_mino_counts.inject(&:+),
          loss_time_str,
          score_count,
        ].flatten.collect{|e|e.to_s}
      }
    }
  end

  def inspect
    save_no = @player_no
    begin
      out = []

      out << "●グローバル情報"
      out << "ファイル名: #{@recfile}"
      out << "カレントプレイヤー: #{save_no.succ}P"

      out << "●サマリー"
      summary.each{|e|
        out << e.inspect
      }

      get_players.each_index{|@player_no|
        out << "●セグメント情報(#{@player_no.succ}P)"
        sections.each{|e|
          out << e.inspect
        }
      }
    ensure
      @player_no = save_no
    end
    out.join("\n")
  end


  ################################################################################
  # maangerから使うために追加したメソッド
  ################################################################################

  def view_segment(i, drawobj=UI::Sdl::Draw.instance)
    RecFile.view(seginfo[i], drawobj)
  end

  def view_last(drawobj=UI::Sdl::Draw.instance)
    RecFile.view(seginfo.last, drawobj)
  end

  def play_segment(i, input_classes)
    RecFile.replay1(seginfo[i], input_classes)
  end

  def replay_segment(i)
    RecFile.replay_a_to_b(seginfo[i], seginfo[i+1]) if seginfo[i+1]
  end

  def replay_first
    RecFile.replay_a_to_b(seginfo.first, seginfo.last)
  end

  def mpeg_convert(output_mpeg)
    frame = Frame.replay_a_to_b(seginfo.first, seginfo.last)
    RecFile.mpeg_convert(frame, output_mpeg)
  end
end

# PostgreSQL対応
class RecFile
  def self.store_db(dbserver, dbname, fname)
#     obj = open(fname)
#     pg = PGconn.connect(dbserver, 5432, '', '', dbname)
#     obj.summary.each{|e|
#       values = e.collect{|v|"'#{v}'"}.join(",")
#       pg.exec("INSERT INTO tetris VALUES(#{values})")
# #       r = pg.exec("SELECT * FROM tetris")
# #       p r.result
#       puts "#{dbserver} の #{dbname} に #{fname} の情報を入力しました。"
#     }
#     pg.close
  end
end

if $0 == __FILE__
  require "manager"

  require 'config'
  require 'ui/frame'

  require "play"
  require "score"
  require "input"
  require "pattern"


#   recfile = File.expand_path("~/src/tetris/_data/replay/FrameMaster/bc30ffab7b9d45495bede7e786dd6fec.rec")
#   RecFile.store_db(CONFIG[:dbserver], CONFIG[:dbname], recfile)
#   exit;


  # ManagerUtil.load_all
  Find.find(CONFIG[:replaydir]){|recfile|
    if /\.rec$/ =~ recfile
      obj = RecFile.open(recfile)
      p obj
      obj.seginfo.each_index{|i|
        obj.view_segment(i)
      }
    end
  }
end
