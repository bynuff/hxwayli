package hxwayli.command.common;

@:enum
abstract CommandType(String) from String to String {
    var Uninst:String = "uninst"; // wayli uninst

    var Init:String = "init"; // wayli init <project_name> <project_path>
    var LsLi:String = "lsli"; // wayli lsli

    var Env:String = "env"; // wayli env <env_name>
    var LsEnv:String = "lsenv"; // wayli lsenv
    var MkEnv:String = "mkenv"; // wayli mkenv <env_name>
    var ClEnv:String = "clenv"; // wayli clenv <env_name>

    var Pack:String = "pack"; // wayli pack <project_name>

    var Help:String = "help"; // wayli help
}
