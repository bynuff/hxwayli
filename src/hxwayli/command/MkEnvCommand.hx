package hxwayli.command;

import haxe.io.Path;
import sys.FileSystem;

class MkEnvCommand implements ICommand {

	var _name:String;

	public function new(name:String) {
		_name = name;
	}

	public function execute():Int {
		FileSystem.createDirectory(Path.join([Sys.getEnv("HAXEPATH"), _name]));
		return 0;
	}

	public function toString():String {
		return "";
	}

}
