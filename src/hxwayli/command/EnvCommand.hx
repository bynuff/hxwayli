package hxwayli.command;

import haxe.io.Path;
class EnvCommand implements ICommand {

	var _name:String;

	public function new(name:String) {
		_name = name;
	}

	public function execute():Int {
		Sys.command("haxelib", ["setup", Path.join([Sys.getEnv("HAXEPATH"), _name])]);
		return 0;
	}

	public function toString():String {
		return "";
	}

}
