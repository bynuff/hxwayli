package ;

import haxe.io.Path;

import sys.io.File;
import sys.FileSystem;

@:final
class SetupScript {

    inline static var LIB_NAME:String = "wayli";

    static var PROGRAM_PATH:Path = new Path(Sys.programPath());

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
        Sys.command("nekotools", ["boot", "wayli.n"]);
    }

    inline static function setupOnUnix() {
        Sys.command("sudo", ["cp", "-f", Path.join([PROGRAM_PATH.dir, LIB_NAME]), "/usr/local/bin/" + LIB_NAME]);
        Sys.command("sudo", ["rm", LIB_NAME, '$LIB_NAME.n']);
    }

    inline static function setupOnWin() {
        var haxePath:String = Sys.getEnv("HAXEPATH");

        if (haxePath == null || haxePath.length == 0) {
            return;
        }

        var targetPath:String = Path.join([haxePath, '$LIB_NAME.exe']);
        var currentPath:String = Path.join([PROGRAM_PATH.dir, '$LIB_NAME.exe']);

        File.copy(currentPath, targetPath);

        Sys.command("cmd", ["del", "/f", "/q", currentPath, Path.join([PROGRAM_PATH.dir, LIB_NAME])]);
    }

}
