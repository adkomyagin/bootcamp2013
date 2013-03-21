
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

var possible = "abcdefghijklmnopqrstuvwxyz";
var names = [];
for (var i=0; i < possible.length - 1; i++) {
	var letter = possible[i];
	var sample = db.messages.find({to:"/^" + letter}}).limit(100);
	names.push(sample);
}
print(names);


var names = ["aaaaho", "aaaald", "aaaao", "aaaaxen", "aaaaxvx", "aaabajwpg", "aaabc", "aaabcpmo", "aaabfjfu", "aaabg", "aaabrpohbl", "aaabxj", "aaacivtjp", "aaacnlrdadi", "aaacpjxu", "aaacrv",
"aaactbtr", "aaadby", "aaaddthb", "aaadu", "aaaejj", "aaafgfifr", "aaafoo", "aaaftge", "aaagpbt", "aaahmqmu", "aaahqvah", "aaahs", "aaahszfd", "aaaht", "aaahwip", "aaahywss", 
"aaaiilrgu", "aaainfbm", "aaaitdmrd", "aaaiyrxn", "aaajchlu", "aaajqdjw", "aaajqwka", "aaajxc", "aaakodz", "aaakp", "aaakwdfi", "aaalixh", "aaalndjvca", "aaalpm", "aaalx", "aaamc", 
"aaamhw", "aaamr", "aaamvyojo", "aaamxg", "aaancaly", "aaaneuke", "aaanhevlw", "aaanuit", "aaaoiwgko", "aaaood", "aaaoznqmon", "aaapd", "aaapdat", "aaaphmxu", "aaapo", "aaapo", 
"aaapp", "aaaps", "aaapxc", "aaapy", "aaaqbr", "aaaqcgfasq", "aaaqnlshop", "aaaqtls", "aaaqvgly", "aaarsmezo", "aaarxywp", "aaascedpfp", "aaashu", "aaashzox", "aaasiz", "aaaskyz", 
"aaasliggvjl", "aaasqoq", "aaass", "aaatdvdf", "aaatfpuq", "aaatoggyo", "aaatoxl", "aaatpsky", "aaatus", "aaatwvoxb", "aaatxkxl", "aaatyj", "aaatzuie", "aaauat", "aaauid", "aaaun",
"aaaurixd", "aaaveccysm", "aaavfxzi", "aaavhjaxt", "aaavokl", "aaavomfkd", "aaawdksd", "aaawer", "aaawgop", "aaawtlws", "aaawulu", "aaawwuo", "aaaxfku", "aaaxgmj", "aaaxgxzhdr",
"aaaxjz", "aaaxmzbg", "aaaxq", "aaaxsc", "aaaxtrh", "aaaxvy", "aaaxz", "aaaycffl", "aaayehs", "aaayeuv", "aaayi", "aaayn", "aaayuj", "aaazphdx", "aaazqrsr", "aabaawe", "aabadcv", 
"aabalnis", "aabanvtaat", "aabasbnt", "aabasn", "aabaumt", "aabavr", "aabavz", "aabayjkasn", "aabazrpzdtcj", "aabbay", "aabbl", "aabbnajo", "aabbnyelr", "aabbqm", "aabbsa", 
"aabbzgxa", "aabcapm", "aabcbzvcdse", "aabcoyomk", "aabdgagz", "aabditu", "aabdtcix", "aabebn", "aabec", "aabednc", "aabek", "aabema", "aabeov", "aabepcizz", "aabeqakeyd", "aabeqbob", 
"aabeqhq", "aabfdcao", "aabfj", "aabfrjxx", "aabfsgdvg", "aabftebbe", "aabgc", "aabgkuqp", "aabgqko", "aabgvq", "aabhdvc", "aabhean", "aabhjuojyf", "aabhnwewme", "aabhpbj", 
"aabhvho", "aabihuc", "aabikiq", "aabioj", "aabjfbh", "aabjjub", "aabjno", "aabjsj", "aabjvembj", "aabjvnlj", "aabkakiovd", "aabkdw", "aabkeqk", "aabkfyabr", "aabkimjra", "aabkol", 
"aabkvfkp", "aableswxw", "aablfcek", "aabljxfyrmv", "aablsmdq", "aablv", "aabmgqrs", "aabmhffkax", "aabmiaju", "aabmkodmfn", "aabmlyjsdu", "aabmsjnpc", "aabmsjqjfn", "aabncpgx", 
"aabndmb", "aabngpt", "aabngq", "aabnuoqdlnwz", "aabob", "aabofb", "aabojbnm", "aabonokkoj", "aabooq", "aaboprhdu", "aaboqe", "aabox", "aabozq", "aabpdcd", "aabpfry", "aabphji", 
"aabpkhyr", "aabpqdl", "aabprfvah", "aabpvj", "aabqci", "aabqupvv", "aabrclbab", "aabreiuv", "aabrfz", "aabrg", "aabrgie", "aabrgurene", "aabrnfrgab", "aabsant", "aabseywwfrvb", 
"aabsgmht", "aabshkn", "aabshkwjm", "aabsllh", "aabsnd", "aabssecovj", "aabsvsoblq", "aabsvwf", "aabtleppjjdn", "aabtonhac", "aabtpbua", "aabtuqr", "aabtzbg", "aabtzof", "aabtzrnj", 
"aabuazogtu", "aabubqcd", "aabumgujo", "aabumkddp", "aabupyzf", "aabusa", "aabusxy", "aabuwsr", "aabvea", "aabvgcrr", "aabvldepp", "aabvruxp", "aabvzhuii", "aabvztg", "aabvzvvgy", 
"aabwf", "aabwhlbbcr", "aabwkmh", "aabwqzwfc", "aabwvvt", "aabwzvhe", "aabxdm", "aabyhb", "aabylof", "aabzcfw", "aabzf", "aabzgmrk", "aabziu", "aabzras", "aabzywl", "aacaeiwdt", 
"aacaknrvf", "aacba", "aacbclqku", "aacbhsif", "aacbmlpwof", "aacbokmz", "aacbsgon", "aacbvs", "aaccbe", "aaccdb", "aaccddfui", "aaccfyrve", "aaccgft", "aaccqcaiy", "aaccql", "aaccuq", 
"aaccze", "aacdessc", "aacdevo", "aacdmx", "aacdpn", "aacdtyof", "aacdwa", "aacealuwupt", "aaceok", "aaceqkiks", "aacerwqf", "aacev", "aacew", "aacewogi", "aacexaa", "aaceyoavq", "aacezv", 
"aacfjlis", "aacftbn", "aacgar", "aacgdapxf", "aacghww", "aacgqd", "aacgz", "aachpft", "aachpxtbl", "aaciax", "aacickgrtw", "aacie", "aaciev", "aacihgli", "aacihqu", "aacika", "aacimpmjir", 
"aacimt", "aacinvu", "aaciuwmcw", "aacixlnt", "aacjcux", "aacjdeuhy", "aacjizcz", "aacjpx", "aacjuuxjs", "aacjvds", "aacjvj", "aacjyr", "aackamkwh", "aackqlytjn", "aackszmgf", "aackzs", 
"aaclasmxq", "aaclbyire", "aaclfappu", "aacmcoe", "aacmeia", "aacmeier", "aacmiqn", "aacmjbe", "aacmjnygnh", "aacmk", "aacmwvilcyz", "aacmzz", "aacnbpaj", "aacndjnig", "aacnigz", "aacnj", 
"aacnqx", "aacntnycc", "aacnvfxqq", "aacnylr", "aacnzvzzell", "aacoj", "aacoro", "aacos", "aacpbsixnfff", "aacpnvgelw", "aacpriw", "aacpvap", "aacqe", "aacqlhc", "aacqsqrgqu", "aacqvsxqml", 
"aacqw", "aacqxo", "aacqzpvgwo", "aacraqvx", "aacrcdm", "aacrhlgdnv", "aacrqecrt", "aacrsnll", "aacrvtboqqg", "aacsbel", "aacsvnewao", "aactah", "aactgx", "aactiid", "aacuaee", "aacubtv", 
"aacuclnva", "aacumfv", "aacupepvrj", "aacuqye", "aacvastbpei", "aacvay", "aacwdy", "aacwugwhd", "aacxbl", "aacxlbvgj", "aacxm", "aacxsy", "aacxunx", "aacxw", "aacxweyb", "aacxx", "aacyae", 
"aacyaranq", "aacydcvxtv", "aacykp", "aacynqwll", "aacyowc", "aaczepup", "aaczitf", "aacznam", "aaczt", "aaczxsz", "aadag", "aadaljv", "aadbeo", "aadbikx", "aadbixjhqim", "aadbxivqqwbo", 
"aadcdzo", "aadcfq", "aadcj", "aadcrifxd", "aadcxxwu", "aadcyrx", "aaddcrkrf", "aaddemiqr", "aaddi", "aaddm", "aaddq", "aaddt", "aadedllp", "aadedqwe", "aadefrjr", "aadenko", "aadenmzz", 
"aaderhodxk", "aadeskml", "aadeucuix", "aadeyojzma", "aadfapc", "aadfbznaq", "aadfkoooy", "aadfqyybs", "aadfwcini", "aadfwvir", "aadfznsh", "aadgaiwqrn", "aadgebr", "aadgizcj", "aadgnt", 
"aadgqmp", "aadgy", "aadhdiuh", "aadhkhdj", "aadhkz", "aadhrg", "aadhri", "aadhvxwd", "aadhzyil", "aadicdlunn", "aadife", "aadihgiy", "aadimbh", "aadinus", "aadiwoxojwo", "aadjel", "aadjgh", 
"aadjhlz", "aadjj", "aadjjs", "aadjtj", "aadjvwuan", "aadjzvyywp", "aadkdj", "aadkit", "aadkoc", "aadkoesm", "aadkqm", "aadlbnnb", "aadlivpzt", "aadlkjw", "aadllk", "aadln", "aadlot", 
"aadlujfxj", "aadlz", "aadmcq", "aadmcw", "aadme", "aadmewr", "aadmguc", "aadmkqg", "aadmm", "aadmrabv", "aadmusnakbj", "aadnbqybs", "aadngmjcsj", "aadnimgrio", "aadny", "aadnyhp", "aadnyumy", 
"aadoas", "aadodq", "aadofxoa", "aadolxlh", "aadopq", "aadowcbk", "aadoxkunqh", "aadoyalh", "aadozc", "aadplvt", "aadpnba", "aadpzyyz", "aadqbef", "aadqfbks", "aadqfgega", "aadqnsjtvi", 
"aadqsnylb", "aadqub", "aadqun", "aadrarbzj", "aadrbwr", "aadrcxg", "aadrgfip", "aadrgy", "aadrqttpt", "aadrvbb", "aadscb", "aadsghh", "aadtcak", "aadtgee", "aadtiqbsuo", "aadtj", "aadtm", 
"aadtrqsm", "aadttbbdnq", "aadudy", "aadue", "aaduktqu", "aadulgvm", "aadur", "aadvcdf", "aadvdtk", "aadvheai", "aadvibe", "aadvkkm", "aadwal", "aadwjoph", "aadwofo", "aadwoq", "aadwp", 
"aadwtgckpn", "aadwwasr", "aadwwc", "aadwxn", "aadxbh", "aadxcnb", "aadxdq", "aadxnwm", "aadxpwb", "aadxyyc", "aadye", "aadyo", "aadyqoilfq", "aadyvsg", "aadyw", "aadyy", "aadzdj", 
"aadzdong", "aadzj", "aadzxcaz", "aadzxyt", "aaeaks", "aaeapdd", "aaeapnobc", "aaeawranci", "aaebaupnve", "aaebbc", "aaebi", "aaebk", "aaebku", "aaebreha", "aaebyr", "aaeckfi", "aaecr", 
"aaecrj", "aaecw", "aaecx", "aaecxd", "aaecxivnl", "aaedcwxo", "aaedj", "aaedjlf", "aaednnis", "aaedomj", "aaedpzw", "aaedqmudz", "aaedumf", "aaedxpcm", "aaeebhd", "aaeec", "aaeeelhe", 
"aaeeg", "aaeejmj", "aaeenr", "aaeepizsg", "aaeevwuvqf", "aaeez", "aaefis", "aaefktnpti", "aaefl", "aaefmli", "aaefovteqkiw", "aaefrzr", "aaefy", "aaefzmmg", "aaegbwbak", "aaegfc", 
"aaegjlfr", "aaegnal", "aaegss", "aaehblsbmh", "aaehbvok", "aaeheb", "aaehewawl", "aaehqk", "aaehtqbfnyo", "aaehtqx", "aaehupqtcl", "aaeialv", "aaeiguxpnx", "aaeihcg", "aaeikn", "aaeio", 
"aaeixwos", "aaejitql", "aaejor", "aaejqsmaf", "aaejslg", "aaejzzi", "aaekfxugc", "aaekgdplh", "aaekhheh", "aaekiyf", "aaekjj", "aaeklcvfn", "aaekmid", "aaekosnhahf", "aaekrq", "aaeksic", 
"aaekt", "aaekwqjmfsk", "aaelddannx", "aaelioli", "aaellzmo", "aaemat", "aaembzm", "aaemixyi", "aaemjgs", "aaemmsc", "aaeni", "aaenkqfw", "aaenlty", "aaensslx", "aaentyio", "aaenwa", 
"aaenxj", "aaeoa", "aaeobg", "aaeokbbu", "aaeooh", "aaeoqhwh", "aaeot", "aaeovrdvyvx", "aaeoysxk", "aaepdkdhk", "aaepean", "aaephfrdu", "aaepiq", "aaepmbzngr", "aaepnrass", "aaeqaqnu", 
"aaeqemz", "aaeqiwdy", "aaeqrnth", "aaerkau", "aaerlc", "aaernglgeu", "aaerryovmf", "aaerue", "aaeshagyckm", "aaeskcbo", "aaesohrf", "aaesvo", "aaetjdlcyk", "aaetjjhh", "aaetmsku", 
"aaetrut", "aaetybzzdo", "aaetyu", "aaeubk", "aaeufbou", "aaeunk", "aaeuv", "aaevdhze", "aaevmmrt", "aaevqu", "aaevs", "aaevuyyp", "aaewkwxgcy", "aaewoy", "aaewugam", "aaewwpngeg", "aaexck", 
"aaexhais", "aaexl", "aaexpu", "aaexusg", "aaeycsv", "aaeygl", "aaeyo", "aaeypjtcjz", "aaeyqk", "aaeyqqcn", "aaeyuhikz", "aaezaf", "aaezcvlu", "aaezjc", "aaezltl", "aaezo", "aaezpvrnoc", 
"aaezxpferp", "aafacygz", "aafadj", "aafadnkd", "aafapnm", "aafasa", "aafauhnq", "aafaulg", "aafbb", "aafbhfj", "aafbkgh", "aafbkojp", "aafbqsbs", "aafbrqxqr", "aafbvu", "aafcnjdw", "aafcpvhn", 
"aafcrhehlwhm", "aafcspkz", "aafczbhzb", "aafdd", "aafdrt", "aafegmcqknz", "aafejvlyv", "aafetk", "aafeyqpg", "aafffy", "aaffgnrs", "aaffgozmfr", "aaffotx", "aaffovjm", "aaffsbx", "aaffyb", 
"aafgjcfep", "aafgm", "aafgn", "aafgoot", "aafgrgt", "aafgsfr", "aafhacxs", "aafhdtrvo", "aafhkgbs", "aafhkozx", "aafhs"]

for (var i=0; i < names.length - 1; i++) {
	var name = names[i];
	db.messages.find({ to: name }).sort({ sent: -1 }).limit(10)	
}

