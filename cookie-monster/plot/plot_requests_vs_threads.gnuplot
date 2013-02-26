#!/bin/sh
gnuplot << EOF

# POINT SIZE AND TYPE
# pointsize is to expand points
  set pointsize 2.5
# type 'test' to see the colors and point types available
# lt is for color of the points: -1=black 1=red 2=grn 3=blue 4=purple 5=aqua 6=brn 7=orange 8=light-brn
# pt gives a particular point type: 1=diamond 2=+ 3=square 4=X 5=triangle 6=*
# postscipt: 1=+, 2=X, 3=*, 4=square, 5=filled square, 6=circle,
#            7=filled circle, 8=triangle, 9=filled triangle, etc.

# LINE COLORS, STYLES 
# type 'test' to see the colors and point types available.
# Differs from x11 to postscript
# lt chooses a particular line type: -1=black 1=red 2=grn 3=blue 4=purple 5=aqua 6=brn 7=orange 8=light-brn
# lt must be specified before pt for colored points
# for postscipt -1=normal, 1=grey, 2=dashed, 3=hashed, 4=dot, 5=dot-dash
# lw chooses a line width 1=normal, can use 0.8, 0.3, 1.5, 3, etc.
# ls chooses a line style

set terminal png large

file = "$1"
output = "$2"

set grid
set nokey
set output output

set xtics 0,1
set xlabel "threads"
set ylabel "requests per sec"
set title "requests/sec vs. threads"

set key on tmargin

plot \
file using 18:1 title "inserts" with points lt 1 pt 3 lc rgb "red" ps 1, \
file using 18:2 title "queries" with points lt 1 pt 5 lc rgb "black" ps 1, \
file using 18:3 title "updates" with points lt 1 pt 8 lc rgb "green" ps 1


EOF
