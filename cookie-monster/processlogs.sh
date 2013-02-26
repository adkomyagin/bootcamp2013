#!/bin/bash

threadcount=$1
step=$2
outdir=$3

# log output
# 8127-1: rate = 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 
# 8127-1: readAvgNS = 196949 199308 197432 200375 218895 205229 198262 199919 197625 198435 
# 8127-1: writeAvgNS = 26312 26280 26353 26464 26452 26382 26292 26432 26476 26228 

echo -e "threads\trate\treadAvgMS\twriteAvgMS"

# pull together the logs
for i in `seq ${step} ${step} ${threadcount}`; do 
    unset rate_totals
    unset rate_counts
    unset read_totals
    unset read_counts
    unset write_totals
    unset write_counts

    # do this so we can use for to iterate on the lines
    OIFS="${IFS}"
    NIFS=$'\n'
    IFS="${NIFS}"

    for line in `grep ': rate = ' ${outdir}/${i}_*`; do
	IFS="${OIFS}"
	#echo $line

        values=${line#*=}; values=($values)
	for ((j = 0; j < ${#values[@]}; j++)); do
	    value=${values[$j]}
	    #echo value: $value
	    if [ "$value" != "" ]; then
		rate_counts[$j]=$((${rate_counts[$j]}+1))
		rate_totals[$j]=$((${rate_totals[$j]}+$value))
	    fi	    
	done

	IFS="${NIFS}"
    done

    for line in `grep ': readAvgNS = ' ${outdir}/${i}_*`; do
	IFS="${OIFS}"

	#echo $line

        values=${line#*=}; values=($values)
	for ((j = 0; j < ${#values[@]}; j++)); do
	    value=${values[$j]}
	    #echo value: $value
	    if [ "$value" != "" ]; then
		read_counts[$j]=$((${read_counts[$j]}+1))
		read_totals[$j]=$((${read_totals[$j]}+$value))
	    fi	    
	done

	IFS="${NIFS}"
    done

    for line in `grep ': writeAvgNS = ' ${outdir}/${i}_*`; do
	IFS="${OIFS}"

	#echo $line

        values=${line#*=}; values=($values)
	for ((j = 0; j < ${#values[@]}; j++)); do
	    value=${values[$j]}
	    #echo value: $value
	    if [ "$value" != "" ]; then
		write_counts[$j]=$((${write_counts[$j]}+1))
		write_totals[$j]=$((${write_totals[$j]}+$value))
	    fi	    
	done

	IFS="${NIFS}"
    done

    IFS="${OIFS}"

    for ((j=0; j < ${#rate_totals[@]}; j++)); do
	read_avg=`echo "scale=4; ${read_totals[$j]} / ${read_counts[$j]} / 1000 / 1000" | bc`
	write_avg=`echo "scale=4; ${write_totals[$j]} / ${write_counts[$j]} / 1000 / 1000" | bc`

	echo -e "$i\t${rate_totals[$j]}\t${read_avg}\t\t${write_avg}"
    done
done