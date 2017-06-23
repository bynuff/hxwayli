package hxwayli.command;

import hxwayli.utils.PathUtils;

using hxwayli.utils.PathUtils;

class UninstCommand extends EnvCommand {

    public function new() {
        super(PathUtils.DEFAULT_ENV_PATH);
    }

    override public function execute():Int {

        super.execute();

        PathUtils.STORAGE_PATH.deleteDirectory();
        PathUtils.WAYLI_PROGRAM_PATH.deleteFile();

        return 0;
    }

    override public function toString():String {
        return "";
    }

}
