
function getRandomInt (min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
};

function getRandomUsername() {
    var text = "";
    var possible = "abcdefghijklmnopqrstuvwxyz";

    for( var i=0; i < getRandomInt(5,13); i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
};

db.messages.drop();
db.messages.ensureIndex({to:1, sent:-1});


for (var i = 0; i < 10000000; i++) {
	var names = [];
	for (var j = 0; j < getRandomInt(1,5); j++) {
	    names.push(getRandomUsername());
	}
	
	var msg = {
		    from: getRandomUsername(),
		    to: unique(names),
			sent: new Date(), 	
			message: "Hi " + getRandomUsername() + "!"
	};
	db.messages.insert(msg);
}










