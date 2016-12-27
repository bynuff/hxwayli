package hxwayli.command;

class CommandFactory {

    public static function getByName(commandType:CommandType, projectPath:String):ICommand {
        switch(commandType) {
            case CommandType.Pack:
                return new PackCommand(projectPath);
            case _:
                // TODO show help
                throw "Command doesn' exist.";
        }
    }

}
