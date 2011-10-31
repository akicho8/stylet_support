# -*- coding: utf-8 -*-
require "test/unit"

$LOAD_PATH << ".."
require "simulator"

class SimulateController < BaseController
  def initialize(speed=nil)
    super()
    @level_info = LevelInfo.new(speed || 20.0, 0.01, 2, 2, 2, nil, 1)
    @power_delay = 1
    @start_delay = 1 + @power_delay
  end
end

Library = [
  {
    :title => "1.TITLE A:B:C",
    :author => "ZON",
    :date => "2000-01-29",
    :url => "http://www.google.co.jp",
    :difficulty => 2.5,
    :comment => "COMMENT",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    cccccc....
    EOT
    :input => <<-EOT
    r| d *
    EOT
  },
  {
    :title => "詰めTGM - ダブル回転入れ",
    :author => "ZON",
    :date => "1999-10-15",
    :url => "http://homepage3.nifty.com/tgm/bbslog9910.html",
    :difficulty => 2,
    :comment => "そんなに難しくはないです",
    :controller => SimulateController.new,
    :pattern => "prob",
    :field => <<-EOT,
    yy......yy
    yy......yy
    yyy....yyy
    EOT
    :input => <<-EOT
    Al| d
    u_ d
    Br* r| B d
    A* C d
    *
    EOT
  },
]

class TestSimHash < Test::Unit::TestCase
  def setup
    @data = SimHash[Library[0]]
  end

  def test_to_a
    result = ["1.TITLE A:B:C", "r", "★★☆", "○", "00-01-29", "ZON", "○", "COMMENT"]
    assert_equal(result, @data.to_a)
  end

  def test_inspect
    assert_equal("[1.TITLE A:B:C,r,★★☆,○,00-01-29,ZON,○,COMMENT]", @data.inspect)
  end

  def test_sample_exist?
    @data[:input] = "r"
    assert_equal(true, @data.sample_exist?)
    @data[:input] = nil
    assert_equal(false, @data.sample_exist?)
    @data[:input] = ""
    assert_equal(false, @data.sample_exist?)
  end

  def test_get_url
    assert_equal("http://www.google.co.jp", @data.get_url)
    @data[:url] = "test://"
    assert_equal(nil, @data.get_url)
    @data[:url] = ""
    assert_equal(nil, @data.get_url)
  end

  def test_get_escape_title
    assert_equal("1TITLEABC", @data.get_escape_title)
  end

  def test_start_auto
    assert_equal(:lost_mino, @data.start_auto(0))
  end
end

class TestSimulator < Test::Unit::TestCase
  def setup
    @data = Library[0]
  end
  def teardown
  end

  def test_start_auto
    assert_equal(:lost_mino, Simulator.start_auto(@data,0))
  end

  # controllerに設定したコントローラーが再生することによって変化してはいけない
  def test_ctrl_param
    a = Marshal.load(Marshal.dump(@data[:controller]))
    Simulator.start_auto(@data,0)
    b = Marshal.load(Marshal.dump(@data[:controller]))

    a2 = a.instance_variables.collect{|var|a.instance_variable_get(var)}
    b2 = b.instance_variables.collect{|var|b.instance_variable_get(var)}
    assert_equal(a2, b2)
  end
end

class TestSimulatorMovieFactory < Test::Unit::TestCase
  SampleMP3 = File.join(File.dirname(__FILE__), "sample.mp3")

  def test_library_to_mpeg
    # テスト用mp3ファイルがあるかチェック
    assert_equal(true, File.exist?(SampleMP3))

    # 作成予定のファイル名作成
    local_mpeg = File.join(CONFIG[:mpegdir], "default", "0-1TITLEABC.mpg")
    joined_mpeg = File.join(CONFIG[:mpegdir], "default.mpg")
    jpeg_file = File.join(CONFIG[:snapdir], "default", "0-1TITLEABC","000000.jpg")
    outfiles = [local_mpeg, joined_mpeg, jpeg_file]

    # 出力ファイルを予め削除
    outfiles.each{|fname|
      File.delete(fname) if File.exist?(fname)
    }

    # 作る人を生成
    factory = Simulator::MovieFactory.new
    factory.overwrite = true
    factory.set_merge_mp3(SampleMP3)

    # factoryの内部のファイルが予想と同じかテスト
    # (local_mpegは内部へ変化していくためテストするのはあまり意味がない)
    assert_equal(joined_mpeg, factory.joined_mpeg)
    assert_equal(SampleMP3, factory.merge_mp3)

    # ソースの準備
    library = Simulator.load_library(Library)

    assert_equal(nil, factory.library_to_mpeg([]))       # 変換するものがない場合
    assert_equal(true, factory.library_to_mpeg(library)) # 変換に成功した場合

    # 出力ファイルの存在チェック
    outfiles.each{|fname|
      assert_equal(true, File.exist?(fname))
    }

    # 作成したルートのファイルの再生確認
    assert_equal(true, Tool.mpeg_player(factory.joined_mpeg))
  end

  # シミュレータファイルを全部変換するテスト(一時間以上かかる)
  def test_files_to_mpeg
#     factory = Simulator::MovieFactory.new
#     factory.overwrite = true
#     factory.set_merge_mp3(SampleMP3)
#     factory.files_to_mpeg
  end
end
