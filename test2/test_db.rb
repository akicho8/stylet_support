# -*- coding: utf-8 -*-
require "test/unit"
require "fileutils"

$LOAD_PATH << ".."
require "ui/frame"
require "recfile"
require "tap_master_mode"
require "db_server"
require "db_client"

class TestDBServer < Test::Unit::TestCase
  CLIENT_DIR   = File.join(File.dirname(File.expand_path(__FILE__)), "_client")
  DATABASE_DIR = File.join(File.dirname(File.expand_path(__FILE__)), "_database")
  DOWN_DIR     = File.join(CLIENT_DIR, "_downdir") # データディレクトリの下になければならない

  REC_NAME = "_tmp.rec"
  REC_FILE = File.join(CLIENT_DIR, REC_NAME)

  def setup

    FileUtils.mkdir_p(CLIENT_DIR)
    FileUtils.mkdir_p(DATABASE_DIR)
    FileUtils.mkdir_p(DOWN_DIR)

    # RECファイル作成
    frame = Modes::FrameMaster.new
    2.times{frame.next_frame}
    frame.save_direct_info
    open(REC_FILE, "w"){|f|f.write(frame.to_marshal_binary)}

    @obj = RecFile.open(REC_FILE)

    CONFIG[:replaydir] = CLIENT_DIR
    DBCONF[:dbdir] = DATABASE_DIR
    CONFIG[:downdir] = DOWN_DIR

    @client = TetrisClient.new
    @server = @client.db
  end

  def teardown
    FileUtils.rm_rf(CLIENT_DIR)
    FileUtils.rm_rf(DATABASE_DIR)
    FileUtils.rm_rf(DOWN_DIR)
  end

  def test_upload
                                                         # クライアント→サーバ
    assert_equal(1, TetrisClient.file_list.size)         # クライアントがもっているファイル数は1
    assert_equal(0, TetrisDB.file_list.size)             # サーバにまだファイルがないので0
    assert_equal(0, @server.file_list.size)              # クライアント側からのアクセスで上と同じ処理
    assert_equal(1, @client.possible_put_files.size)     # クライアントにあってサーバにないファイルのリスト
    @client.put_files(*@client.possible_put_files)       # クライアント→サーバにアップロード
    assert_equal(1, TetrisDB.file_list.size)             # アップロードされたのでファイル数が1になる

                                                         # サーバ→クライアント
    assert_equal(0, @client.possible_get_files.size)     # クライアントになくてサーバにあるファイルのリスト
    File.delete(REC_FILE)
    assert_equal(1, @client.possible_get_files.size)     # クライアントになくてサーバにあるファイルのリスト
    assert_equal([REC_NAME], @client.possible_get_files) # クライアントになくてサーバにあるファイルのリスト
    assert(@server.get(REC_NAME).size >= 1)              # サーバからファイルをバイナリで取得したい場合
    @client.get_files(*@client.possible_get_files)       # サーバから取り寄せる
    assert_equal(0, @client.possible_get_files.size)     # 同期したので0
  end
end
