package hxwayli.command;

@:enum
abstract CommandType(String) from String to String {
    var Pack:String = "pack";
    var Help:String = "help";
}
