# mongomonitor.sh

This is a simple script intended to monitor hosts running mongod.  To install, just
copy it to the desired location on the target machine.  It runs mongostat and iostat
as background processes, redirecting their output to temporary log files.  It then 
tails those log files and puts all of the columns from the last line in each file onto
a single line and writes it to std out.  Redirect std out to a file to save the results.

## Usage

mongomonitor.sh [--port arg] <device name>

--port arg&nbsp;&nbsp;specifies the port to connect to  
device name&nbsp;&nbsp;specifies the device to collect iostat metrics on
