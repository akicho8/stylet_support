#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
# シミュレーションファイルを走査してWEBページを生成する

$CREAET_DEBUG = false
$DIR_PREFIX = "_"

require "optparse"
require "cgi"
require "erb"

$LOAD_PATH << Pathname(__FILE__).dirname.join("..")

require "dbconfig"
require "recfile"
require "simulator.rb"

# require 'ui/frame'

require "load_all"


module SimHashForWebSite
  # ウェブサイト用のハッシュデータに変換
  def to_website
    {
      :title => self[:title],
      :pattern => self[:pattern].pattern_to_kanji_str_pattern,
      :difficulty => to_s_difficulty,
      :timestamp => !to_s_date.empty? ? to_s_date : "00-00-00",
      :author => self[:author],
      :url => get_url ? get_url : "",
      :comment => self[:comment],
      :field => Field.create(self[:field]).to_web_s,
    }
  end

end

# 拡張
class SimHash
  include SimHashForWebSite
end

module MpegCreateForWeb
  def library_to_mpeg_for_web(library)
    outputs = []
    library.each_with_index{|e, i|
      mpeg_title = "#{i}"
      set_jpeg_dir(mpeg_title)
      set_mpeg_title(mpeg_title)
      if data_to_mpeg(e)
        outputs << @local_mpeg
        puts "outout mpeg: #{@local_mpeg}"
      end
    }
    if outputs.size >= 1
      if Tool.mpeg_join(@joined_mpeg, outputs)
        if @merge_mp3 && File.exist?(@merge_mp3)
          Tool.mpeg_add_audio(@joined_mpeg, @merge_mp3)
        end
        true
      end
    end
  end
  def copy_to_webdir

    # デフォルトのディレクトリに吐かれたファイルをWEB用のディレクトリに持ってく
    # る。データの :input が nil の場合にはディレクトリが作成されないためディレ
    # クトリのチェックを行なっている。

    webdir = Pathname(__FILE__).dirname

    # 動画のコピー
    mpeg_root_dir = File.join(CONFIG[:mpegdir], @group)
    if File.directory?(mpeg_root_dir)
      command = "cp -vr #{mpeg_root_dir} #{webdir}/#{$DIR_PREFIX}mpeg"
      puts command
      `#{command}`
    end

    # 静止画のコピー
    if false
      jpeg_root_dir  = File.join(CONFIG[:snapdir], @group)
      if File.directory?(jpeg_root_dir)
        command = "cp -vr #{jpeg_root_dir} #{webdir}/#{$DIR_PREFIX}snapshot"
        puts command
        `#{command}`
      end
    end

    #       p jpeg_root_dir
    #       p mpeg_root_dir
  end
end

module Simulator
  class MovieFactory
    include MpegCreateForWeb
  end
end

module FieldForWeb
  def to_web_s(first=get_top, last=bottom)
    first -= 3
    str = "\n"
    str << "<pre>\n"
    (first..last).each {|y|
      str << "｜"
      width.times {|x|
        str << (get(x, y).exist? ? "■" : "　")
      }
      str << "｜\n"
    }
    str << "└" + "─" * width + "┘" + "\n"
    str << "</pre>\n"
  end
end

class Field
  include FieldForWeb
end

class PageCreator
  attr_accessor :option, :info
  def initialize(info)
    @info = info
    # @library = Simulator.load_file(@info[:source])
    @library = Simulator.load_file(@info[:source])
    @library = [@library[0]] if $CREAET_DEBUG
  end

  def data_name
    File.basename(@info[:source], ".rb")
  end

  # ブラウザタイトル
  def title
    "テトリス妙技動画集 | #{header}"
  end

  # ページのヘッダ
  def header
    ""
  end

  # コンテンツ全体の取得
  def output
    ERB.new(File.open("template.rhtml"){|f|f.read}).result(binding)
  end

  # シミュレータファイル一つに対して一つ存在するファイル
  def base_filename
    "#{$DIR_PREFIX}#{data_name}.html"
  end

  # シミュレータファイル一つに対して複数在するMPEGファイル名
  def mpeg_filename(i)
    "#{$DIR_PREFIX}mpeg/#{data_name}/#{i}.mpg"
  end

  # シミュレータファイル一つに対して複数在する詳細ファイル
  def detail_filename(i)
    "#{$DIR_PREFIX}#{data_name}-#{i}.html"
  end

  # シミュレータファイル一つに対して一つある画像ディレクトリのルート
  def snapshot_dir
    "#{$DIR_PREFIX}snapshot/#{data_name}"
  end

  # シミュレータファイル一つに対して複数ある画像リストファイル
  def snapshot_filename(i)
    "#{$DIR_PREFIX}#{data_name}-#{i}-snapshot.html"
  end

  # シミュレータファイル一つに対して複数あるデータの中のさらに複数の画像ファイル
  def snapshot_files(i)
    Dir["#{snapshot_dir}/#{i}/*.jpg"].sort
  end

  # ファイルに出力
  def output_file
    File.open(@filename, "w") {|f|
      f.write(output)
      puts "outout #{@filename}"
    }
  end
end

class TopListCreator < PageCreator
  def initialize(*args)
    super
  end
  def create
    to_mpeg
    to_html
  end
  def contents
    ERB.new(File.open("list.rhtml"){|f|f.read}).result(binding)
  end
  def title
    "テトリス妙技動画集(#{header})"
  end
  def header
    "#{@info[:title]}"
  end
  def to_html
    @filename = base_filename
    output_file
  end
  def to_mpeg
    return unless @option[:mpeg]
    factory = Simulator::MovieFactory.new
    factory.set_group(data_name)
    factory.library_to_mpeg_for_web(@library);
    factory.copy_to_webdir
  end
end

class DetailCreator < PageCreator
  def initialize(*args)
    super
    @data = nil
  end
  def create
    to_html
  end
  def contents
    ERB.new(File.open("detail.rhtml"){|f|f.read}).result(binding)
  end
  def title
    "テトリス妙技動画集(#{header})"
  end
  def header
    "#{@data[:title]}"
  end
  def to_html
    @library.each_with_index{|@data, i|
      @curno = i
      @filename = detail_filename(i)
      output_file
    }
  end
end

class SnapshotCreator < PageCreator
  def create
    @library.each_with_index{|@data, i|
      @curno = i
      @filename = snapshot_filename(i)
      @files = snapshot_files(i)
      output_file
    }
  end
  def contents
    ERB.new(File.open("snapshot.rhtml"){|f|f.read}).result(binding)
  end
  def title
    "テトリス妙技動画集(#{header})"
  end
  def header
    "#{@data[:title]}"
  end
end

class IndexCreator < PageCreator
  def initialize(fileinfo)
    @fileinfo = fileinfo
  end
  def create
    @filename = "index.php"
    output_file
  end
  def contents
    ERB.new(File.open("index.rhtml"){|f|f.read}).result(binding)
  end
  def title
    "#{header}"
  end
  def header
    "テトリス妙技動画集"
  end
end


class MainCreator
  def initialize
    info = [
#       {
#         :source => "../simulator/sample.rb",
#         :title => "サンプル",
#       },
      {
        :source => "../simulator/panoo_basic_technique.rb",
        :title => "テトリス基本技編(作者ぱのおさん)",
      },
      {
        :source => "../simulator/ipepapi_boyaki.rb",
        :title => "テトリス情報のページぼやき編(作者いぺぱぴさん)",
      },
#       {
#         :source => "../simulator/zon_checkmate.rb",
#         :title => "詰めテトリス編(作者ZONさん)",
#       },
#       {
#         :source => "../simulator/ipepapi_checkmate.rb",
#         :title => "詰めテトリス編(作者いぺぱぴさん)",
#       },
#       {
#         :source => "../simulator/ipepapi_synchro_checkmate.rb",
#         :title => "シンクロ専用詰めテトリス編(作者いぺぱぴさん)",
#       },
      {
        :source => "../simulator/goo_mino_controll_optimize.rb",
        :title => "ブロック操作最適化編(作者GOOさん)",
      },
    ]
    info.each{|data|
      obj = TopListCreator.new(data)
      obj.option = $option
      obj.create

      obj = DetailCreator.new(data)
      obj.option = $option
      obj.create

      obj = SnapshotCreator.new(data)
      obj.option = $option
      obj.create
    }

    obj = IndexCreator.new(info)
    obj.create
  end
end

$option = {}
ARGV.options {|q|
  q.banner = "Usage: #{$0} [options]\n"
  q.on_head("options:")
  q.on("--html", "htmlの生成") {|$option[:html]|}
  q.on("--mpeg", "mpegの生成") {|$option[:mpeg]|}
  q.on_tail("-h", "--help", "ヘルプ表示") {
    print(q.to_s)
    exit
  }
}

# if ARGV.size == 0
#   print ARGV.options.to_s
#   exit
# end

ARGV.parse!
MainCreator.new
