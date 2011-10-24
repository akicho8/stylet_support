#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# グラフ表示/gnuplot関係

require "recfile"

module Graph
  class Graph
    attr_reader :script, :datafile

    def self.useful?
      Tool.gnuplot_useful?
    end

    def initialize(rec)
      @rec = rec
    end

    def view(tmpname)
      setup(tmpname)
      Thread.new{
        `gnuplot #{File.expand_path(@script)}`
      }
    end

    def setup(tmpname)
      @script = File.expand_path(File.join(CONFIG[:graphdir], "#{tmpname}.gp"))
      @datafile = @script.sub(/\w+$/, "dat")

      @script = File.expand_path(@script)
      open(@script, "w"){|io|io.write(make_script(@datafile))}
      File.chmod(0777, @script)
      puts "WRITE #{script}" if $DEBUG

      @datafile = File.expand_path(@datafile)
      open(@datafile, "w"){|io|io.write(make_data)}
      puts "WRITE #{@datafile}" if $DEBUG
    end

    def clean
      [@script, @datafile].each{|fname|
        File.delete(fname) if File.exist?(fname)
      }
    end

    private

    def level_max
      @rec.get_players.last.controller.level_max
    end

    def level_interval
      @rec.get_players.last.controller.level_interval
    end

    def make_script(data)
    end

    def make_data
    end
  end

  class GraphSection < Graph
    def make_script(data)
      <<-E
#!/usr/bin/gnuplot -persist
set title "区間タイム遷移"
set xlabel "LEVEL"
set ylabel "(秒)"
set xrange [0:#{level_max}]
set yrange [0:80]
set xtics 0,#{level_interval}
set ytics 0,10
set grid
plot "#{@datafile}" title "区間タイム" with linespoints
pause -1
E
    end

    def view(tmpname="default")
      super("#{tmpname}.section")
    end

    def make_data
      # 11,00:12:75,00:12:75,9,12,1,1,0,0,2,00:02:35,26
      @rec.sections.collect{|ary|
        lv, tm, stm = ary
        "#{lv} #{min_sec_msec_to_sec_msec(stm)}\n"
      }.join("")
    end

    private
    def min_sec_msec_to_sec_msec(stm)
      # "01:23:45" => 83.45
      min, sec, msec = stm.scan(/\d+/).collect{|e|e.to_i}
      min * 60 + sec + msec/100.0
    end

  end

  class GraphBlock < Graph
    def make_script(data)
<<-E
#!/usr/bin/gnuplot -persist

set title "消去ブロック"
set xlabel "LEVEL"
set ylabel "消去ブロック"
set xrange [0:#{level_max}]
set yrange [0:5]
set xtics 0,#{level_interval}
set ytics 0,1,4
set grid
plot "#{@datafile}" title "消去ブロック" with impulses
pause -1
E
    end

    def view(tmpname="default")
      super("#{tmpname}.mino")
    end

    def make_data
      # 19,00:20:25,00:07:50,9,11,2,0,0,0,2,00:02:35,38
      @rec.sections.collect{|ary|
        "#{ary[0]} #{ary[9]}\n"
      }.join("")
    end
  end
end

if $0 == __FILE__
end
