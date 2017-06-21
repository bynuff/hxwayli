package hxwayli.command.common;

class CommandProvider {

    public static function resolveByName(commandType:CommandType, args:Array<String>):ICommand {
        return switch(commandType) {
//            case CommandType.LsLi:
            case CommandType.Pack:
                new PackCommand(args.shift());
            case CommandType.Env:
                new EnvCommand(args.shift());
//            case CommandType.LsEnv:
            case CommandType.MkEnv:
                new MkEnvCommand(args.shift());
//            case CommandType.ClEnv:
            case CommandType.Uninst:
                new UninstCommand();
            case _:
                new HelpCommand();
        }
    }

}
