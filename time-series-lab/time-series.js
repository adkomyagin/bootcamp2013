//-----------------------------------------------------------------------------
// Document per sample (dps)  
//

function DocumentPerSample() { 

    this.preload = function() {
        this.db = db.getSisterDB("labs_cpu").dps
    };

    this.init = function() {
        this.db.drop()
        this.db.ensureIndex({'server' : 1, 'timestamp' : 1})
    };

    this.store = function( server_name, cpu_measurement, timestamp ) { 
        // implement the mongodb method to store a sample
        this.db.insert({'server' : server_name, 'load' : cpu_measurement, 'timestamp' : timestamp})
    };

    this.query = function( server_name, start, end ) {
        // return the set of documents for that server over the specified 
        // time range. don't worry about aggregating the data, just return 
        // all of the docs that you need for hte answer 
        // remember to actually drain the cursor! (hint: "itcount()")
        var cur = this.db.find({'server' : server_name, 'timestamp' : {'$gte' : start, '$lte' : end}})
        cur.itcount()
    };

}


//-----------------------------------------------------------------------------
// Document per hour (dph)
//

function DocumentPerHour() { 

    this.preload = function() {
        this.db = db.getSisterDB("labs_cpu").dph
    };

    this.init = function() {
        this.db.drop()
        this.db.ensureIndex({'server' : 1, 'hour' : 1})
    };

    this.store = function( server_name, cpu_measurement, timestamp ) { 
        var ts = new Date(timestamp)
        ts.setMinutes(0)
        ts.setSeconds(0)
        ts.setMilliseconds(0)
        this.db.update({server: server_name, hour: ts}, { $inc: {load_sum : cpu_measurement, load_count : 1} }, {upsert : true})
    };

    this.query = function( server_name, start, end ) {
        // return the set of documents for that server over the specified 
        // time range. don't worry about aggregating the data, just return 
        // all of the docs that you need for hte answer 
        // remember to actually drain the cursor! (hint: "itcount()")
        var cur = this.db.find({'server' : server_name, 'hour' : {'$gte' : start, '$lte' : end}})
        cur.itcount()
    };
}

//-----------------------------------------------------------------------------
// Document per day (dpd)
//

function DocumentPerDay() { 

    this.preload = function() {
        this.db = db.getSisterDB("labs_cpu").dpd
    };

    this.init = function() {
        this.db.drop()
        this.db.ensureIndex({'server' : 1, 'day' : 1})
    };

    this.store = function( server_name, cpu_measurement, timestamp ) { 
        var ts = new Date(timestamp)
        var hour = ts.getHours()
        ts.setHours(0)
        ts.setMinutes(0)
        ts.setSeconds(0)
        ts.setMilliseconds(0)
        var hr_sum = "hours." + hour + ".sum"
        var hr_count = "hours." + hour + ".count"
        var zzz = {}
        zzz[hr_sum] = cpu_measurement
        zzz[hr_count] = 1
        this.db.update({server: server_name, day: ts}, 
            { $inc: zzz }, 
            {upsert : true})
    };

    this.query = function( server_name, start, end ) {
        // return the set of documents for that server over the specified 
        // time range. don't worry about aggregating the data, just return 
        // all of the docs that you need for hte answer 
        // remember to actually drain the cursor! (hint: "itcount()")
        var cur = this.db.find({'server' : server_name, 'day' : {'$gte' : start, '$lte' : end}})
        cur.itcount()
    };
}
