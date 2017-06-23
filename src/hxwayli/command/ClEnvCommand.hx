package hxwayli.command;

import hxwayli.user.storage.UserStorage;
import hxwayli.command.common.ICommand;

using StringTools;
using hxwayli.utils.PathUtils;

class ClEnvCommand implements ICommand {

    var _name:String;

    public function new(name:String) {
        _name = name;
    }

    public function execute():Int {
        if (UserStorage.settings.currentEnv == _name) {
            // TODO: refactor me
            Sys.command("wayli", ["env", "lib"]);
        }
        if (UserStorage.removeEnv(_name)) {
            UserStorage.getEnvPath(_name).deleteDirectory();
        }

        return 0;
    }

    public function toString():String {
        return "";
    }

}
