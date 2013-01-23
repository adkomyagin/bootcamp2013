var year = 2012;
var month = 9; // (0-11)

// external var dayCount = 1;
// external var hostCount = 100000;

// vary they number of days to change the size of the working set

for (;;) {
    day = Random.randInt(dayCount) + 1;
    machine = Random.randInt(hostCount) + 1;
    match = { year : year, month : month, day : day, "m" : "m" + machine };
    db.cpudata.aggregate({$match : match}, { $sort : { "hour" : 1 }}, {$limit : 24 }, { $project : { "_id" : "$m", "hour" : 1, "load" : { $divide : ["$sum", "$count"] }}});
}
