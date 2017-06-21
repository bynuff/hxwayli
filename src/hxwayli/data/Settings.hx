package hxwayli.data;

typedef Settings = {
    var version:String;
    var currentEnv:String;
    var envList:Array<String>;
    var devlibList:Array<Devlib>;
}

typedef Devlib = {
    var name:String;
    var path:String;
}
