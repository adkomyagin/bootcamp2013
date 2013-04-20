// This is a driver program that loads data using the methods implemented 
// in the student's "time-series.js" file. 

load("time-series.js");

// we expect that file to define Classes for each implementation 

var dps = new DocumentPerSample();
var dph = new DocumentPerHour();
var dpd = new DocumentPerDay(); 

// we expect that the caller told us how many servers to simulate 

print("Querying " + serverCount + " servers at " + new Date());

// and how big a time period we should query data for 

print("Loading the last " + dayCount + " days of samples");

// and which model to use 
print("With the " + impl + " implementation");
var engine = null; 
if(impl=="sample") engine = dps;
if(impl=="hour") engine = dph;
if(impl=="day") engine = dpd;

for(;;) { 
    var server = "server" + Random.randInt(serverCount);
    engine.aggregate_query( server, dayCount );  
}
