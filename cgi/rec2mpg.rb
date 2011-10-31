#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
# データベースに保存されているrecをmpgに変換する

$LOAD_PATH << ".."

require "dbconfig"
require "recfile"

require "manager"

require "config"
require "ui/frame"

require "play"
require "score"
require "input"
require "pattern"

File.makedirs("mpeg", $DEBUG)
files = Dir[File.join(DBCONF[:dbdir], "*")]
files.each {|recfile|
  mpgfile = File.join("mpeg", File.basename(recfile,".rec") + ".mpg")
  if File.exist?(mpgfile)
    puts "#{mpgfile} exist."
  else
    obj = RecFile.open(recfile)
    obj.mpeg_convert(mpgfile)
    puts "#{mpgfile} created."
  end
}
