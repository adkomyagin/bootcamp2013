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

set terminal png

file = "$1"
output = "$2"

set output "tmp.png"

plot file u 1
min_y = GPVAL_DATA_Y_MIN
max_y = GPVAL_DATA_Y_MAX
max_x = GPVAL_DATA_X_MAX

f(x) = mean_y
fit f(x) file u 0:1 via mean_y

stddev_y = sqrt(FIT_WSSR / (FIT_NDF + 1 ))

set label 1 gprintf("Minimum = %g", min_y) at 5, max_y
set label 2 gprintf("Maximum = %g", max_y) at max_x * .25, max_y
set label 3 gprintf("Mean = %g", mean_y) at max_x * .5, max_y
set label 4 gprintf("Std dev = %g", stddev_y) at max_x * .75, max_y

print("Minimum = %g", min_y)
print("Maximum = %g", max_y)
print("Mean = %g", mean_y)
print("Std dev = %g", stddev_y)

set output output

plot file u 1 w p pt 7 lt 1 ps 1

EOF