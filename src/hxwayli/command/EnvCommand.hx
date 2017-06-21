package hxwayli.command;

import hxwayli.user.storage.UserStorage;
import hxwayli.command.common.ICommand;

class EnvCommand implements ICommand {

    var _name:String;

    public function new(name:String) {
        _name = name;
    }

    public function execute():Int {
        if (UserStorage.envExists(_name)) {
            Sys.command("haxelib", ["setup", UserStorage.getEnvPath(_name)]);
            return 0;
        }
        return 1;
    }

    public function toString():String {
        return "";
    }

}
