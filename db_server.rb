#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
# データベース

require "dbconfig"

class LightTetrisDB
  VERSION = "1.0.0"
  def initialize
    @mutex = Mutex.new
    write_log "DB NEW"
  end

  # データベースに入れる
  def put(fname, bin)
    @mutex.synchronize {
      fname = File.join(DBCONF[:dbdir], File.basename(fname))
      open(fname, "w"){|f|f.write(bin)}
      write_log "DB PUT OK #{File.basename(fname)} (#{bin.size})"
      fname
    }
  end

  # データベースから出す
  def get(fname)
    @mutex.synchronize {
      fname = File.join(DBCONF[:dbdir], File.basename(fname))
      bin = open(fname).read
      write_log "DB GET OK #{File.basename(fname)} (#{bin.size})"
      bin
    }
  end

  # データベース内のリストを取得
  def self.file_list
    Dir[File.join(DBCONF[:dbdir], "*")].collect{|fname|
      File.basename(fname)
    }
  end
  def file_list; self.class.file_list; end

  # データベース内にログを書き込む(ここに @mutex.synchronize してはいけない)
  def write_log(str)
    str = Time.now.strftime("%y/%m/%d %H:%M:%S") << " " << str
    open(DBCONF[:log], "a") {|io|io.puts str}
    puts str
  end

end

class TetrisDB < LightTetrisDB
  def initialize(*args)
    super
  end
  def put(*args)
    fname = super
    RecFile.store_db(DBCONF[:dbserver], DBCONF[:dbname], fname)
  end
end

if $0 == __FILE__
  if false
    p TetrisDB.file_list
    exit
  end
  require 'drb/drb'
  db = TetrisDB.new
  DRb.start_service(DBCONF[:uri], db)
  db.write_log "URI #{DRb.uri}"
  DRb.thread.join
end
