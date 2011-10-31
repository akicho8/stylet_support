#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
# 環境設定


# データベースは一つだけ。

require "ftools"
require "pathname"

# デフォルト設定
DBCONF = {
  :uri   => "druby://localhost:8470",
  :dbdir => Pathname(__FILE__).dirname.join("_database.db").expand_path,
  :log   => Pathname(__FILE__).dirname.join("_access.log").expand_path,
  :dbserver   => "libretto",
  :dbname   => "server_tetris",
}

# user_conf = Pathname("~/.dbtetrisrc").expand_path
# if user_conf.exist?
#   load test_conf
# end

# test_conf = Pathname(__FILE__).dirname.join("dbtest.conf").expand_path
# if test_conf.exist?
#   load test_conf
# end

File.makedirs(DBCONF[:dbdir], $DEBUG)

if $0 == __FILE__
  p DBCONF
  puts File.directory?(DBCONF[:dbdir]) ? "OK" : "Error"
end
