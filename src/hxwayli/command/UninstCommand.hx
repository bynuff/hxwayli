package hxwayli.command;

import haxe.io.Path;
import sys.FileSystem;
import hxwayli.user.storage.UserStorage;
import hxwayli.command.common.ICommand;

class UninstCommand implements ICommand {

    public function new() {}

    public function execute():Int {

        // TODO: remove lib hxwayli from haxelib
        // TODO: set haxelib repository to default path
        // TODO: refactor me
        UserStorage.clearStorage();

        if (~/windows/i.match(Sys.systemName())) {
            FileSystem.deleteFile(Path.join([Sys.getEnv("HAXEPATH"), "wayli.exe"]));
        } else {
            FileSystem.deleteFile("/usr/local/bin/wayli");
        }

        return 0;
    }

    public function toString():String {
        return "";
    }

}
