#!/bin/bash

#Config: threads = 1; requests = 20000; request rate = 0
#3417: aggregate rate = 2629 2569 2813 2829 2873 2862 2860 2766
#3417: aggregate readAvgNS = 205392 207849 179384 178147 176557 178211 177510 185838
#3417: aggregate writeAvgNS = 21826 21972 21902 21858 21865 21908 21772 21801

# transform to:
# threads aggregate_rate aggregate_readAvgNS aggregate_writeAvgNS

CONFIG_LINE="Config:"
RATE_LINE="aggregate rate"
READ_LINE="aggregate readAvgNS"
WRITE_LINE="aggregate writeAvgNS"

config=""
rates=""
reads=""
writes=""

echo -e "threads\trate\treadAvg(MS)\twriteAvg(MS)"

cat $1 | while read line; do
    case $line in
    # match exact string
    # "$searchString") echo yep, it matches exactly;;
  
    # match start of string
	"$CONFIG_LINE"*) config=$line ;;

    # match end of string
    # *"$searchString") echo yep, it matches at the end ;;

    # searchString can be anywhere in thisString
	*"$RATE_LINE"*) rates=$line ;;
 	*"$READ_LINE"*) reads=$line ;;
 	*"$WRITE_LINE"*) writes=$line ;;
  
    # *) echo nope ;;
    esac    

    if [[ "$config" != "" && "$rates" != "" && "$reads" != "" && "$writes" != "" ]]; then
	# dump a row for each rate, read and write value
        threads=`echo $config|sed -e 's/.*threads = \([0-9]*\)\; req.*/\1/g'`
        rate_values=${rates#*=}; rate_values=($rate_values)
        read_values=${reads#*=}; read_values=($read_values)
        write_values=${writes#*=}; write_values=($write_values)

        for ((i = 0; i < ${#rate_values[@]}; i++)); do
            rate=${rate_values[$i]}
            read=`echo "scale=4; ${read_values[$i]} / (1000*1000)"|bc`
            write=`echo "scale=4; ${write_values[$i]} / (1000*1000)"|bc`
            echo -e "$threads\t$rate\t$read\t\t$write"
	done

	# reset for a new section
	config=""
	rates=""
	reads=""
	writes=""
    fi

done