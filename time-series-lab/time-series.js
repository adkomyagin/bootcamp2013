

//-----------------------------------------------------------------------------
// Document per sample (dps)  
//

function DocumentPerSample() { 

    this.store = function( server_name, cpu_measurement, timestamp ) { 
        // implement the mongodb method to store a sample
        print("store: " + server_name + " " + cpu_measurement + " " + timestamp );
    };

    this.simple_query = function( server_name, days_ago ) {
        // return the set of documents for that server over the specified 
        // time range. don't worry about aggregating the data, just return 
        // all of the docs that you need for hte answer 
        print("simple: " + server_name + " " + days_ago );
    };
     
    this.aggregate_query = function( server_name, days_ago ) { 
        // this time return data aggregated for the caller 
        // return a document that looks like this: 
        // { loads: [ 23, 32, 12, 52, 34, 12, 12 ] } 
        // where there is 1 number for each hour starting from hour 0
        print("agg: " + server_name + " " + days_ago );
    };

}


//-----------------------------------------------------------------------------
// Document per hour (dph)
//

function DocumentPerHour() { 

    this.store = function( server_name, cpu_measurement, timestamp ) { 
        // implement the mongodb method to store a sample
    };

    this.simple_query = function( server_name, days_ago ) {
        // return the set of documents for that server over the specified 
        // time range. don't worry about aggregating the data, just return 
        // all of the docs that you need for hte answer 
    };
     
    this.aggregate_query = function( server_name, days_ago ) { 
        // this time return data aggregated for the caller 
        // return a document that looks like this: 
        // { loads: [ 23, 32, 12, 52, 34, 12, 12 ] } 
        // where there is 1 number for each hour starting from hour 0
    };

}

//-----------------------------------------------------------------------------
// Document per day (dpd)
//

function DocumentPerDay() { 

    this.store = function( server_name, cpu_measurement, timestamp ) { 
        // implement the mongodb method to store a sample
    };

    this.simple_query = function( server_name, days_ago ) {
        // return the set of documents for that server over the specified 
        // time range. don't worry about aggregating the data, just return 
        // all of the docs that you need for hte answer 
    };
     
    this.aggregate_query = function( server_name, days_ago ) { 
        // this time return data aggregated for the caller 
        // return a document that looks like this: 
        // { loads: [ 23, 32, 12, 52, 34, 12, 12 ] } 
        // where there is 1 number for each hour starting from hour 0
    };
}
