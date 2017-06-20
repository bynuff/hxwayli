package hxwayli.data;

typedef Settings = {
    var env:Array<String>;
    var wayli:Array<Wayli>;
    var customCmds:Array<String>;
}

typedef Wayli = {
    var name:String;
    var path:String;
}
