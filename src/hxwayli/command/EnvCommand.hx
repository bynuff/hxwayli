package hxwayli.command;

import hxwayli.user.storage.UserStorage;
import hxwayli.command.common.ICommand;

class EnvCommand implements ICommand {

    var _name:String;

    public function new(name:String) {
        _name = name;
    }

    public function execute():Int {
        // TODO: refactor me
        if (UserStorage.settings.currentEnv != _name && UserStorage.envExists(_name)) {
            UserStorage.settings.currentEnv = _name;
            @:privateAccess UserStorage.flush();
            Sys.command("haxelib", ["setup", UserStorage.getEnvPath(_name)]);
        }
        return 0;
    }

    public function toString():String {
        return "";
    }

}
