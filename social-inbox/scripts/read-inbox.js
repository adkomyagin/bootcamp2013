


function getRandomInt (min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
};

function unique(origArr) {  
    var newArr = [],  
        origLen = origArr.length,  
        found,  
        x, y;  
          
    for ( x = 0; x < origLen; x++ ) {  
        found = undefined;  
        for ( y = 0; y < newArr.length; y++ ) {  
            if ( origArr[x] === newArr[y] ) {   
              found = true;  
              break;  
            }  
        }  
        if ( !found) newArr.push( origArr[x] );      
    }  
   return newArr;  
}; 

var firstNames = ["Andy", "Ed", "Joe", "James", "Mark", "William", "David", "Paul", "Matthew", "Susan", "Kenny", "Kyle",
                  "Tim", "Tom", "Steve", "Victor", "Tammy", "Tonya", "Tina", "Amanda", "Cindy", "Samantha", "Kelly"];

function getRandomName() {
	return firstNames[getRandomInt(0, firstNames.length-1)];
};

var name = getRandomName();
print(name);
db.messages.find({ to: name }).sort({ sent: -1 }).limit(10)
