package ;

import sys.FileSystem;

import hxwayli.command.common.ICommand;
import hxwayli.command.common.CommandType;

using hxwayli.command.common.CommandProvider;

class Main {

    public static function main() {
        var args:Array<String> = Sys.args();

        var commandName:CommandType = args.length > 0 ? args.shift() : "";
//        var projectPath:String = args.length > 0 ? args.shift() : "";

//        if (projectPath != "" && !FileSystem.exists(projectPath)) {
//             TODO throw exception
//            return;
//        }

        var command:ICommand = commandName.resolveByName(args);

        if (command != null) {
            command.execute();
            Sys.println(command.toString());
        }
    }

}
