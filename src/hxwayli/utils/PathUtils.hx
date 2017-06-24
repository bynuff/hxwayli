package hxwayli.utils;

using StringTools;

@:final
class PathUtils {

    inline public static var DEFAULT_ENV_PATH:String = "lib";

    public static var HAXE_PATH(get, never):String;
    public static var STORAGE_PATH(get, never):String;
    public static var SETTINGS_PATH(get, never):String;
    public static var WAYLI_PROGRAM_PATH(get, never):String;

    static var systemPathes:IPathes = getSystemPathes();

    public static function joinPathes(pathes:Array<String>):String {
        return systemPathes.join(pathes);
    }

    public static function createDirectory(path:String) {
        systemPathes.createDirectory(path);
    }

    public static function deleteDirectory(path:String) {
        systemPathes.deleteDirectory(path);
    }

    public static function createFile(path:String) {
        systemPathes.createFile(path);
    }

    public static function deleteFile(path:String) {
        systemPathes.deleteFile(path);
    }

    macro static function getSystemPathes() {
        var className = Type.getClassName(~/windows/i.match(Sys.systemName()) ? WinPathes : UnixPathes).split(".").pop();
        return macro ${haxe.macro.Context.parse('new $className()', haxe.macro.Context.currentPos())};
    }

    static function get_HAXE_PATH():String {
        return systemPathes.haxePath;
    }

    static function get_STORAGE_PATH():String {
        return joinPathes([HAXE_PATH, "wayli/local"]);
    }

    static function get_SETTINGS_PATH():String {
        return joinPathes([STORAGE_PATH, "settings.json"]);
    }

    static function get_WAYLI_PROGRAM_PATH():String {
        return systemPathes.wayliProgramPath;
    }

}

@:final
private class UnixPathes implements IPathes {

    public var haxePath:String;
    public var separateChar:String;
    public var wayliProgramPath:String;

    public function new() {
        separateChar = "/";
        haxePath = "/usr/local/lib/haxe";
        wayliProgramPath = "/usr/local/bin/wayli";
    }

    public function normalize(path:String):String {
        return path.replace("\\", separateChar);
    }

    public function createDirectory(path:String) {
        Sys.command("sudo", ["mkdir", "-m", "777", normalize(path)]);
    }

    public function deleteDirectory(path:String) {
        Sys.command("sudo", ["rm", "-rf", normalize(path)]);
    }

    public function createFile(path:String) {
        Sys.command("sudo", ["echo", ">", normalize(path)]);
    }

    public function deleteFile(path:String) {
        deleteDirectory(path);
    }

    public function join(pathes:Array<String>):String {
        return normalize(pathes.join(separateChar));
    }

}

@:final
private class WinPathes implements IPathes {

    public var haxePath:String;
    public var separateChar:String;
    public var wayliProgramPath:String;

    public function new() {
        separateChar = "\\";
        haxePath = normalize(Sys.getEnv("HAXEPATH"));
        wayliProgramPath = join([haxePath, "wayli.exe"]);
    }

    public function normalize(path:String):String {
        return path.replace("/", separateChar);
    }

    public function createDirectory(path:String) {
        Sys.command("mkdir", [normalize(path)]);
    }

    public function deleteDirectory(path:String) {
        Sys.command("rmdir", ["/s", "/q", normalize(path)]);
    }

    public function createFile(path:String) {
        Sys.command("echo", [">", normalize(path)]);
    }

    public function deleteFile(path:String) {
        Sys.command("del", ["/s", "/f", "/q", normalize(path)]);
    }

    public function join(pathes:Array<String>):String {
        return normalize(pathes.join(separateChar));
    }

}

private interface IPathes {

    var haxePath:String;
    var separateChar:String;
    var wayliProgramPath:String;

    function createDirectory(path:String):Void;

    function deleteDirectory(path:String):Void;

    function createFile(path:String):Void;

    function deleteFile(path:String):Void;

    function join(pathes:Array<String>):String;

    function normalize(path:String):String;

}
