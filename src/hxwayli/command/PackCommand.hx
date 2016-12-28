package hxwayli.command;

import hxwayli.data.Manifest;
import haxe.zip.Entry;
import haxe.io.Path;
import haxe.Json;
import sys.io.File;
import haxe.io.Bytes;
import sys.FileSystem;

using hxwayli.utils.ZipExtensions;
using hxwayli.utils.ListExtensions;

class PackCommand implements ICommand {

    static var MANIFEST_PATTERN:EReg = ~/\.wli$/;

    var _projectPath:String;

    public function new(projectPath:String) {
        _projectPath = projectPath;
    }

    public function execute():Int {
        var manifest:Manifest = loadManifest();

        if (manifest == null) {
            // TODO throw exception
            return 1;
        }

        var entries:List<Entry> = new List<Entry>();

        for (item in manifest.zip.include) {
            entries.addRange(Path.join([_projectPath, item]).createEntries(item));
        }

        entries.makeZipPackage(Path.join([_projectPath, manifest.zip.name]));
        return 0;
    }

    public function toString():String {
        return "";
    }

    function loadManifest():Manifest {
        for (file in FileSystem.readDirectory(_projectPath)) {
            if (MANIFEST_PATTERN.match(file)) {
                var bytes:Bytes = File.getBytes(Path.join([_projectPath, file]));
                return Json.parse(bytes.toString());
            }
        }
        return null;
    }

}
