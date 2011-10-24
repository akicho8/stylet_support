#!/usr/local/bin/ruby -Ku
# データベースにアクセスするクライアント側の処理

=begin

CLIENT: RECファイルは replaydir 以下にバラバラに存在する
SERVER: RECファイルは一つのディレクトリで管理される

=end

require "drb/drb"
require "md5"
require "optparse"
require "find"

require "config"

class TetrisClient

  attr_reader :db

  def initialize
    begin
      DRb.start_service
      @db = DRbObject.new(nil, CONFIG[:uri])
      @db.write_log("CL CONNECT BY DRB")
    rescue
      @db = nil
      if CONFIG[:localdb]
        require 'db_server'
        @db = TetrisDB.new
        @db.write_log("CL DEBUG CONNECT")
      end
    end
  end

  def online?
    !@db.nil?
  end

  def offline?
    @db.nil?
  end

  # DB側のファイルリスト
  def db_file_list
    @db.file_list
  end

  # クライアント側のデータリスト(フルパス)
  def TetrisClient.file_list2
    list = []
    Find.find(CONFIG[:replaydir]){|recfile|
      unless File.directory? recfile
        list << recfile
      end
    }
    list
  end

  # クライアント側のデータリスト(ファイル名のみ)
  def TetrisClient.file_list
    file_list2.collect{|recfile|
      File.basename(recfile)
    }
  end

  # DBにアップロード可能なファイル一覧を取得
  def possible_put_files(files=TetrisClient.file_list2)
    list = @db.file_list
    files.find_all{|recfile|
      !list.include?(File.basename(recfile))
    }
  end

  # 指定ファイルがDBにあるか?
  def already_file_exist?(recfile)
    @db.file_list.include?(File.basename(recfile))
  end

  # 指定した複数のファイルを転送する
  def put_files(*files, &mino)
    files.each_with_index{|recfile, i|
      mino.call(File.basename(recfile), i) if mino
      @db.write_log "CL PUT RQ #{File.basename(recfile)} (#{File.size(recfile)}) [#{i.succ}/#{files.size}]"
      @db.put(recfile, File.open(recfile).read)
    }
  end

  # サーバにファイルを全てアップロードする
  def put_all(&mino)
    put_files(*possible_put_files, &mino)
  end

  # DB側にあってクライアント側にないファイル一覧
  def possible_get_files
    @db.file_list - TetrisClient.file_list
  end

  # 指定したファイルをダウンロードする
  def get_files(*files, &mino)
    files.each_with_index{|recfile, i|
      outfile = File.join(CONFIG[:downdir], recfile)
      bin = @db.get(recfile)
      open(outfile, "w"){|io|io.write(bin)}
      @db.write_log "CL GET OK #{File.basename(outfile)} (#{bin.size}) [#{i.succ}/#{files.size}]"
      RecFile.store_db(CONFIG[:dbserver], CONFIG[:dbname], outfile)
    }
  end

  # DBからファイルを全てダウンロードする
  def get_all(&mino)
    get_files(*possible_get_files, &mino)
  end

end

if $0 == __FILE__
  p TetrisClient.file_list2
  p TetrisClient.file_list
  p TetrisClient.new.possible_put_files
  TetrisClient.new.put_all
  TetrisClient.new.get_all
end
