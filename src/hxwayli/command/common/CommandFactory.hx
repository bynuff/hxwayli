package hxwayli.command.common;

class CommandFactory {

    public static function getByName(commandType:CommandType, args:Array<String>):ICommand {
        return switch(commandType) {
            case CommandType.Init:
                new InitCommand();
//            case CommandType.LsLi:
            case CommandType.Pack:
                new PackCommand(args.shift());
            case CommandType.Env:
                new EnvCommand(args.shift());
//            case CommandType.LsEnv:
            case CommandType.MkEnv:
                new MkEnvCommand(args.shift());
//            case CommandType.ClEnv:
            case _:
                new HelpCommand();
        }
    }

}
