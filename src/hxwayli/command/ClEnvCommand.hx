package hxwayli.command;

import hxwayli.user.storage.UserStorage;
import hxwayli.command.common.ICommand;

using StringTools;

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
            if (~/windows/i.match(Sys.systemName())) {
                Sys.command("del", ["/f", "/q", UserStorage.getEnvPath(_name).replace("/", "\\")]);
            } else {
                Sys.command("sudo", ["rm", "-rf", UserStorage.getEnvPath(_name)]);
            }
        }

        return 0;
    }

    public function toString():String {
        return "";
    }

}
