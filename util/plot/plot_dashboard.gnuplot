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

set terminal png size 800, 800

file = "$1"
output = "$2"

set grid
set output output

set multiplot layout 3,2        # engage multiplot mode

set xlabel "time (seconds)"

set ylabel "operations per sec"
set title ""

set key above

# columns 1-19
# insert	query	update	delete	getmore	command	flushes	mapped	vsize	res	faults	locked-db	%idx-miss	qr|qw	ar|aw	netIn	netOut	conn	time	
# columns 20-37
# %user	%nice	%system	%iowait	%steal	%idle	Device:	rrqm/s	wrqm/s	r/s	w/s	rkB/s	wkB/s	avgrq-sz	avgqu-sz	await	svctm	%util

plot \
file using 1 axes x1y1 title "insert" with linespoints lc rgb "blue" lt 7 lw 1 pt 1 ps 1, \
file using 2 axes x1y1 title "query" with linespoints lc rgb "red" lt 7 lw 1 pt 7 ps 1, \
file using 3 axes x1y1 title "update" with linespoints lc rgb "green" lt 7 lw 1 pt 2 ps 1, \
file using 4 axes x1y1 title "delete" with linespoints lc rgb "purple" lt 7 lw 1 pt 4 ps 1, \
file using 5 axes x1y1 title "getmore" with linespoints lc rgb "orange" lt 7 lw 1 pt 5 ps 1, \
file using 6 axes x1y1 title "command" with linespoints lc rgb "yellow" lt 7 lw 1 pt 6 ps 1

set key off
set ylabel "faults per sec"
set title "page faults"

plot \
file using 11 axes x1y1 title "faults" with lines linecolor rgb "blue" linetype 7 lw 1

set key off
set ylabel "% db locked"
set title "Percentage Locked"

plot \
file using 12 axes x1y1 title "% locked" with lines linecolor rgb "blue" linetype 7 lw 1

set key on
set ylabel "Count"
set title ""

plot \
file using 14 axes x1y1 title "qr" with lines linecolor rgb "blue" linetype 7 lw 1, \
file using 15 axes x1y1 title "ar" with lines linecolor rgb "red" linetype 7 lw 1, \
file using 18 axes x1y1 title "connections" with lines linecolor rgb "green" linetype 7 lw 1

set key on
set ylabel "%"
set title ""

# %user (20)	%nice	%system	%iowait	%steal	%idle $diskutil (37)

# may have to shift these if mongostat is run against a replicaset or mongos
shift=0

plot \
file using 20+shift axes x1y1 title "%user" with lines linecolor rgb "blue" linetype 7 lw 1, \
file using 22+shift axes x1y1 title "%system" with lines linecolor rgb "red" linetype 7 lw 1, \
file using 23+shift axes x1y1 title "%iowait" with lines linecolor rgb "green" linetype 7 lw 1, \
file using 25+shift axes x1y1 title "%idle" with lines linecolor rgb "orange" linetype 7 lw 1

set key off
set ylabel "%"
set title "Disk Utilization"

plot \
file using 37+shift axes x1y1 title "%disk util" with lines linecolor rgb "blue" linetype 7 lw 1


EOF
