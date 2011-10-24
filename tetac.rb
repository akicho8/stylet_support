#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
# テトリスの全消しパターンを調べるツール
# TA積も順: bromycgrbmcoybr

require File.expand_path(File.dirname(__FILE__) + "/init")

require "config"
require "optparse"
require "tetris"
require "backtrack"
require "ui/field"

# オプションのデフォルト設定
$OPT = {:width => "10"}

GUI_FPS = 60*256                # 値を小さくするとスローになる

ARGV.options {|opts|
  opts.banner = <<END
テトリス全消しパターン探索プログラム Version 1.0.0

使い方: #{File.basename($0)} [オプション] <ブロック順序>

END
  opts.on_head("■オプション")
  opts.on
  opts.on("-a", "--[no-]all=[FLAG]", "すべての結果を表示") {|$OPT[:all]|}
  opts.on("-w", "--width=[NUMBER]", "フィルードの幅を指定する") {|$OPT[:width]|}
  opts.on("-s", "--[no-]sdl=[FLAG]", "SDLで経過を表示") {|$OPT[:sdl]|}
  opts.on_tail("--help", "このヘルプを表示") {print opts; exit}
  opts.on_tail(<<END)

■ブロック色とアルファベットの対応

    黄 青 橙 緑 紫 水 赤
     y  b  o  g  m  c  r

■実行例

(1) #{File.basename($0)} -w8 rr    フィールド幅8、ツモ順「赤赤」の条件で解を求める
(2) #{File.basename($0)} -w8 rr -g 上記と同じ条件で、経過をグラフィック表示する
(3) #{File.basename($0)} -a yyyrr  ツモ順「黄黄黄赤赤」で「すべて」の解を求める
END
}

begin
  ARGV.parse!
rescue OptionParser::InvalidOption
  puts "オプションが間違っています。"; exit
end

if ARGV.empty?
  puts "使い方: #{File.basename($0)} [オプション] <ブロック順序>"
  puts "`#{File.basename($0)} --help' でより詳しい情報が表示されます。"
  exit
end

# フィールドが小さすぎるブロックを動かせないのでチェック
dim = Mino::Classic.field_area
if $OPT[:width].to_i < dim.width
  puts "フィールド幅は #{dim.width} 以上を指定してください。"; exit
end

minos = ARGV.shift
hit = 0

print_proc = lambda{|field|
  hit += 1
  puts "-" * 40
  puts "#{hit} 件目の結果"
  puts
  print field.to_s3
  puts
  field.history.each_with_index{|mino, i|
    puts "#{("%2d" % i.next)}: #{mino.color} => (#{mino.pos.x+1},#{field.height - mino.pos.y})"
  }
}

backtrack = BackTrack.new(minos, $OPT[:width].to_i, 20+Field::INVISIBLE_AREA, $OPT[:all], &($OPT[:cui] ? nil : print_proc))

gui = UI::DrawField.new(backtrack, UI::Sdl::Draw.instance)
result = catch(:exit) {
  backtrack.backtrack
}
if result == :break
  puts "中止しました。"
  exit
end

if hit >= 1
  puts "-" * 40
  if $OPT[:all]
    "合計 #{hit} 件、見つかりました。"
  else
    "別解も調べる場合は -a オプションを指定してください。"
  end
else
  "#{minos} の順序では、ひとつも解が見つかりませんでした。"
end.display; puts
