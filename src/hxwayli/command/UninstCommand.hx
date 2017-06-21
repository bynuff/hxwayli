package hxwayli.command;

import haxe.io.Path;
import hxwayli.command.common.ICommand;

class UninstCommand implements ICommand {

    public function new() {}

    public function execute():Int {

        // TODO: remove lib hxwayli from haxelib
        // TODO: set haxelib repository to default path
        // TODO: refactor me
        if (~/windows/i.match(Sys.systemName())) {
            Sys.command("del", ["/f", "/q", Path.join([Sys.programPath(), "wayli"])]);
            Sys.command("del", ["/f", "/q", Path.join([Sys.getEnv("HAXEPATH"), "wayli.exe"])]);
        } else {
            Sys.command("sudo", ["rm", "-rf", Path.join([Sys.programPath(), "wayli"])]);
            Sys.command("sudo", ["rm", "-rf", "/usr/local/bin/wayli"]);
        }

        return 0;
    }

    public function toString():String {
        return "";
    }

}
