package ;

import sys.io.File;
import haxe.io.Path;

@:final
class SetupScript {

    inline static var LIB_NAME:String = "wayli";

    static var PROGRAM_PATH:String = new Path(Sys.programPath()).dir;

    public static function setup() {
        buildLib();
        if (~/windows/i.match(Sys.systemName())) {
            setupOnWin();
        } else {
            setupOnUnix();
        }
    }

    inline static function buildLib() {
        Sys.command("haxe", ["build.hxml"]);
        Sys.command("nekotools", ["boot", '$LIB_NAME.n']);
    }

    inline static function setupOnUnix() {
        Sys.command("sudo", ["cp", "-f", Path.join([PROGRAM_PATH, LIB_NAME]), "/usr/local/bin/" + LIB_NAME]);
        Sys.command("sudo", ["rm", LIB_NAME, '$LIB_NAME.n']);
    }

    inline static function setupOnWin() {
        var haxePath:String = Sys.getEnv("HAXEPATH");

        if (haxePath == null || haxePath.length == 0) {
            throw "HAXEPATH not set in system variables!";
        }

        File.copy(
            Path.join([PROGRAM_PATH, '$LIB_NAME.exe']),
            Path.join([haxePath, '$LIB_NAME.exe'])
        );

        Sys.command("cd", [PROGRAM_PATH]);
        Sys.command("del", ["/f", "/q", '$LIB_NAME.exe', '$LIB_NAME.n']);
    }

}
