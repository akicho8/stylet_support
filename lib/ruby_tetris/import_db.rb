#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
# データベースにファイルの情報を入力する

require "config"
require "find"
require "recfile"

# ローカル
Find.find(CONFIG[:replaydir]){|recfile|
  if /\.rec$/ =~ recfile
    RecFile.store_db(CONFIG[:dbserver], CONFIG[:dbname], recfile)
  end
}

# サーバ側
require "dbconfig"
Find.find(DBCONF[:dbdir]){|recfile|
  if /\.rec$/ =~ recfile
    RecFile.store_db(DBCONF[:dbserver], DBCONF[:dbname], recfile)
  end
}
