# -*- coding: utf-8 -*-
#
# テトリスの全消しパターンを調べるツール
#
# TA積も順: bromycgrbmcoybr
#

require File.expand_path(File.join(File.dirname(__FILE__), "config"))
require File.expand_path(File.join(File.dirname(__FILE__), "init"))
require File.expand_path(File.join(File.dirname(__FILE__), "backtrack"))
require File.expand_path(File.join(File.dirname(__FILE__), "ui/field"))

require "optparse"

GUI_FPS = 60*256                # 値を小さくするとスローになる

module RubyTetris
  module TetacCLI
    def self.execute(args)
      options = {
        :width => "10",
      }
      oparser = OptionParser.new do |oparser|
        oparser.version = "0.0.1"
        oparser.banner = [
          "テトリス全消しパターン探索プログラム #{oparser.ver}",
          "使い方: #{oparser.program_name} [オプション] <ブロック順序>",
        ].collect{|e|e + "\n"}
        oparser.on("-a", "--[no-]all=[FLAG]", "すべての結果を表示") {|options[:all]|}
        oparser.on("-w", "--width=[NUMBER]", "フィルードの幅を指定する", Integer) {|options[:width]|}
        oparser.on("-s", "--[no-]sdl=[FLAG]", "SDLで経過を表示") {|options[:sdl]|}
        oparser.on(<<-EOT)

■ブロック色とアルファベットの対応

    黄 青 橙 緑 紫 水 赤
     y  b  o  g  m  c  r

■実行例

(1) #{oparser.program_name} -w8 rr    フィールド幅8、ツモ順「赤赤」の条件で解を求める
(2) #{oparser.program_name} -w8 rr -g 上記と同じ条件で、経過をグラフィック表示する
(3) #{oparser.program_name} -a yyyrr  ツモ順「黄黄黄赤赤」で「すべて」の解を求める
(4) #{oparser.program_name} -a bromycgrbmcoybr ツモ順「bromycgrbmcoybr」で「すべて」の解を求める(恐しく時間がかかる)

EOT
      end

      args = oparser.parse(args)

      # フィールドが小さすぎるブロックを動かせないのでチェック
      dim = Mino::Classic.field_area
      if options[:width].to_i < dim.width
        puts "フィールド幅は #{dim.width} 以上を指定してください。"; exit
      end

      minos = args.shift
      hit = 0

      print_proc = lambda{|field|
        hit += 1
        puts "-" * 40
        puts "#{hit} 件目の結果"
        puts
        puts field.to_s(:ustrip => true)
        puts
        field.history.each_with_index{|mino, i|
          puts "#{("%2d" % i.next)}: #{mino.color} => (#{mino.pos.x+1},#{field.height - mino.pos.y})"
        }
      }

      backtrack = BackTrack.new(minos, options[:width].to_i, 20+Field::INVISIBLE_AREA, options[:all], &(options[:cui] ? nil : print_proc))

      if options[:sdl]
        gui = UI::DrawField.new(backtrack)
        result = catch(:exit) {
          backtrack.backtrack
        }
        if result == :break
          puts "中止しました。"
          exit
        end
      else
        backtrack.backtrack
      end

      if hit >= 1
        puts "-" * 40
        if options[:all]
          puts "合計 #{hit} 件、見つかりました。"
        else
          puts "別解も調べる場合は -a オプションを指定してください。"
        end
      else
        puts "#{minos} の順序では、ひとつも解が見つかりませんでした。"
      end
    end
  end
end

if $0 == __FILE__
  RubyTetris::TetacCLI.execute(ARGV)
end

