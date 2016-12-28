package hxwayli.command;

class CommandFactory {

    public static function getByName(commandType:CommandType, projectPath:String):ICommand {
        return switch(commandType) {
            case CommandType.Pack:
                new PackCommand(projectPath);
            case _:
                new HelpCommand();
        }
    }

}
