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

set terminal png large size 800,600

file = "$1"
output = "$2"

set grid
set output output

set ylabel "ops per sec"
set y2label "disk %util"
set xlabel "working set size (MB)"
set title "Read-only load against increasing working set size (4 cores, 16 GB RAM)"

set y2tics border

set key on tmargin



plot \
file using 38:6 axes x1y1 title "queries per sec" with points pt 7 lt 6 ps 1, \
file using 38:37 axes x1y2 title "disk %util" with lines lt 19 lw 2.5, \
file using 38:11 axes x1y1 title "page faults per sec" with lines lt 8 lw 2.5


#, \
#7500 axes x1y1 title "cpu limit" with lines linecolor rgb "black" lt 0 lw 2.5, \
#800 axes x1y1 title "disk limit" with lines linecolor rgb "black" lt 2 lw 2.5

#, \
#15 axes x1y2 title "Available RAM" with lines linecolor rgb "green" lt 1 lw 2.5

EOF
