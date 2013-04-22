

//-----------------------------------------------------------------------------
// Document per sample (dps)  
//

function DocumentPerSample() { 

    this.store = function( server_name, cpu_measurement, timestamp ) { 
        // implement the mongodb method to store a sample
    };

    this.query = function( server_name, start, end ) {
        // return the set of documents for that server over the specified 
        // time range. don't worry about aggregating the data, just return 
        // all of the docs that you need for hte answer 
        // remember to actually drain the cursor! (hint: "itcount()")
    };

}


//-----------------------------------------------------------------------------
// Document per hour (dph)
//

function DocumentPerHour() { 

    this.store = function( server_name, cpu_measurement, timestamp ) { 
        // implement the mongodb method to store a sample
    };

    this.query = function( server_name, days_ago ) {
        // return the set of documents for that server over the specified 
        // time range. don't worry about aggregating the data, just return 
        // all of the docs that you need for hte answer 
        // remember to actually drain the cursor! (hint: "itcount()")
    };
}

//-----------------------------------------------------------------------------
// Document per day (dpd)
//

function DocumentPerDay() { 

    this.store = function( server_name, cpu_measurement, timestamp ) { 
        // implement the mongodb method to store a sample
    };

    this.query = function( server_name, days_ago ) {
        // return the set of documents for that server over the specified 
        // time range. don't worry about aggregating the data, just return 
        // all of the docs that you need for hte answer 
        // remember to actually drain the cursor! (hint: "itcount()")
    };
}
