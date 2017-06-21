package hxwayli.command;

import hxwayli.user.storage.UserStorage;
import hxwayli.command.common.ICommand;

class InitCommand implements ICommand {

    public function new() {}

    public function execute():Int {
        // TODO: refactor me
        if (!UserStorage.isStorageExists) {
            @:privateAccess UserStorage.initStorage();
        }
        return 0;
    }

    public function toString():String {
        return "";
    }

}
