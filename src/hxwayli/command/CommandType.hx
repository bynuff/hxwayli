package hxwayli.command;

@:enum
abstract CommandType(String) from String to String {
    var Env:String = "env";
    var LsEnv:String = "lsenv";
    var MkEnv:String = "mkenv";
    var ClEnv:String = "clenv";
    var Pack:String = "pack";
    var Help:String = "help";
}
