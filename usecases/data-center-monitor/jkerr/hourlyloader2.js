// same as hourloader.js but uses a "right-balanced index"

var now = new Date();

// start a year ago and move forward in time
var startDate = new Date(now.getFullYear() - 1, now.getMonth(), now.getDate(), now.getHours());
var sampleInterval = 300;
var samplesPerHour = 60 * 60 / sampleInterval;
var currentDate = startDate;

/*
 * external vars
 * var hostIdStart = 1;
 * var hostCount = 100000;
 * var doUpdates = true;
 */

print("hostIdStart=" + hostIdStart);
print("hostCount=" + hostCount);
print("doUpdates=" + doUpdates);

db.cpudata.ensureIndex({ year : 1, month : 1, day : 1, m : 1, hour : 1 });

for (;;) {
    print("date=" + currentDate + " (hosts " + hostIdStart + " to " + (hostIdStart + hostCount - 1) + ")");

    for (hostId = hostIdStart; hostId <= hostIdStart + hostCount; hostId++ ) {
        host = "m" + hostId;
        if (doUpdates) {
            for (i = 0; i < samplesPerHour; i++) {
	        db.cpudata.update(
	            {
		        "year" : currentDate.getFullYear(),
		        "month" : currentDate.getMonth(),
		        "day" : currentDate.getDate(),
			"m" : host, 
			"hour": currentDate 
		    },
	            { "$inc" : { "sum" : Random.randInt(100), "count" : 1 }},
	            { "upsert" : true }
	        );
	    }
	} else {
            // just insert one doc to represent all the updates
            db.cpudata.insert(
	        {
		    "m" : host, 
		    "year" : currentDate.getFullYear(),
		    "month" : currentDate.getMonth(),
		    "day" : currentDate.getDate(),
		    "hour": currentDate, 
		    "sum" : Random.randInt(100 * samplesPerHour), 
		    "count" : samplesPerHour 
		}
	    );
	}
    }

    // move to the next hour
    currentDate = new Date(currentDate.getTime() + 60*60*1000);
}
