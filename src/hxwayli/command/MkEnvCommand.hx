package hxwayli.command;

import hxwayli.user.storage.UserStorage;
import hxwayli.command.common.ICommand;

class MkEnvCommand implements ICommand {

    var _name:String;

    public function new(name:String) {
        _name = name;
    }

    public function execute():Int {
        UserStorage.createEnv(_name);
        return 0;
    }

    public function toString():String {
        return "";
    }

}
