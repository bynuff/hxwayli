package ;

import sys.FileSystem;

import hxwayli.command.ICommand;
import hxwayli.command.CommandType;

using hxwayli.command.CommandFactory;

class Main {

    public static function main() {
        var args:Array<String> = Sys.args();

        if (args == null || args.length != 2) {
            // TODO throw exception
            return;
        }

        var commandName:CommandType = args.shift();
        var projectPath:String = args.shift();

        if (!FileSystem.exists(projectPath)) {
            // TODO throw exception
            return;
        }

        var command:ICommand = commandName.getByName(projectPath);

        if (command != null) {
            command.execute();
            Sys.println(command.toString());
        }
    }

}
