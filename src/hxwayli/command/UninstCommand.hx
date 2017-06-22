package hxwayli.command;

import haxe.io.Path;

class UninstCommand extends EnvCommand {

    public function new() {
        // TODO: refactor me
        super("lib");
    }

    override public function execute():Int {

        super.execute();

        // TODO: remove lib hxwayli from haxelib
        // TODO: refactor me
        if (~/windows/i.match(Sys.systemName())) {
            Sys.command("cd", ["/"]);
            Sys.command("del", ["/f", "/q", Path.join([Sys.programPath(), "wayli"])]);
            Sys.command("del", ["/f", "/q", Path.join([Sys.getEnv("HAXEPATH"), "wayli.exe"])]);
        } else {
            Sys.command("sudo", ["rm", "-rf", Path.join([Sys.programPath(), "wayli"])]);
            Sys.command("sudo", ["rm", "-rf", "/usr/local/bin/wayli"]);
        }

        return 0;
    }

    override public function toString():String {
        return "";
    }

}
