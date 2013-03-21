
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

var name = getRandomUsername();
print(name);
db.messages.find({ to: name }).sort({ sent: -1 }).limit(10)
