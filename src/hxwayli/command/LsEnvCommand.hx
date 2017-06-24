package hxwayli.command;

import hxwayli.user.storage.UserStorage;
import hxwayli.command.common.ICommand;

class LsEnvCommand implements ICommand {

    var _msg:String = "";

    public function new() {}

    public function execute():Int {
        var counter = 0;
        _msg = ' Current environment: ${UserStorage.settings.currentEnv} [lib - default haxelib env]';

        for (env in UserStorage.settings.envList) {
            if (counter % 3 == 0) {
                _msg += "\n";
            }
            counter++;
            _msg += '  [$counter]: $env';
        }

        return 0;
    }

    public function toString():String {
        return _msg;
    }

}
