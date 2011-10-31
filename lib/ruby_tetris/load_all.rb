#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
# manager.rb の中の表示に関係しない操作をここに取り出す。

require "config"
require "rubyext"

module ManagerUtil
  module_function

  # モード・ファイルの読み込み
  def player_load
    Dir[File.join(CONFIG[:inputdir], "*" + ".rb")].sort.each{|file|
      # puts "require #{file}"
      require file
    }
  end

  # モード・ファイルの読み込み
  def modes_load
    Dir[File.join(CONFIG[:modesdir], "*" + ".rb")].sort.each{|file|
      # puts "require #{file}"
      require file
    }
  end

  def load_all
    player_load
    modes_load
  end
end

if $0 == __FILE__
end

ManagerUtil.load_all
