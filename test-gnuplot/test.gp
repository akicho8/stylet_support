#!/usr/bin/env gnuplot

set title "区間タイムの遷移"
set xlabel "LEVEL"
set ylabel "(秒)"
set xrange [0:999]
set yrange [0:80]
set xtics 0,100,999
set ytics 0,10
set grid
plot "section.dat" title "区間タイム" with linespoints
pause -1

set title "消去ブロック"
set xlabel "LEVEL"
set ylabel "消去ブロック"
set xrange [0:999]
set yrange [0:5]
set ytics 0,1,4
set xtics 0,100,999
set grid
plot "mino.dat" title "消去ブロック" with impulses
pause -1

# set boxwidth 1
# set yrange [0:4]
# replot "gpdata2.dat" title "消去ブロック" with impulses
