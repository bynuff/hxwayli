package hxwayli.command;

import hxwayli.data.HelpConfig;
import hxwayli.macro.JsonMacro;

class HelpCommand implements ICommand {

    var _result:String;

    public function new() {}

    public function execute():Int {
        var helpConfig:HelpConfig = JsonMacro.parseJson("configs/help.json");
        _result = helpConfig.title + "\n";
        for (b in helpConfig.body) {
            _result += b.header + "\n";
            for (t in b.text) {
                _result += t + "\n";
            }
        }

        return 0;
    }

    public function toString():String {
        return _result;
    }

}
