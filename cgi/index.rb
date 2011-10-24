#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
# データベース・ファイルを走査してWEBページを作成する

require "cgi"
require "erb"

$LOAD_PATH << Pathname(__FILE__).dirname.join("..")

require "dbconfig"
require "recfile"

# require 'ui/frame'

require "load_all"

# require "config"
# @cgi=#{CGI.escapeHTML($form.inspect)}<br>

class TopPage
  TDB_VERSION = "1.0.0"
  def initialize(cgi)
    @cgi = cgi
  end
  def title
    "テトリス・ハイスコア・ランキング"
  end
  def output
    ERB.new(File.open("template.rhtml"){|f|f.read}).result(binding)
  end
  def contents
    ERB.new(File.open("list.rhtml"){|f|f.read}).result(binding)
  end
end

class AppMain
  def initialize
    @cgi = CGI.new
    case @cgi.params["cmd"][0]
    when "debug"
    else
      print TopPage.new(@cgi).output
    end
  end
end

AppMain.new
