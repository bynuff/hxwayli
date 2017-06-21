package hxwayli.user.storage;

import haxe.Json;
import hxwayli.data.Settings;
import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;

@:final
class UserStorage {

    static var SETTINGS_FILE:String = "settings.json";
    static var STORAGE_PATH:String = Path.join([Sys.programPath(), "local"]);
    static var EMPTY_SETTINGS:Settings = {env: [], wayli: [], customCmds: []};

    public static var settings(get, never):Settings;
    public static var isStorageExists(get, never):Bool;

    static var _settings:Settings;

    public static function createEnv(name:String) {
        // TODO: check that is the envName couldn't be default (reserved env name)
        if (!envExists(name)) {
            _settings.env.push(name);
            FileSystem.createDirectory(Path.join([STORAGE_PATH, name]));

            flush();
        }
    }

    public static function removeEnv(name:String) {
        // TODO: check is it active env
        if (envExists(name)) {
            _settings.env.remove(name);
            FileSystem.deleteDirectory(Path.join([STORAGE_PATH, name]));

            flush();
        }
    }

    public static function getAllEnv():Array<String> {
        return _settings.env.copy();
    }

    public static function envExists(name:String):Bool {
        return _settings.env.indexOf(name) >= 0;
    }

    public static function getEnvPath(name:String):String {
        return Path.join([STORAGE_PATH, name]);
    }

    public static function createWayli(name:String, path:String) {
        if (getWayliByName(name) != null) {
            // TODO: throw exception, project already registered
            return;
        }
        _settings.wayli.push({name: name, path: path});

        flush();
    }

    public static function removeWayli(name:String) {
        var wayli = getWayliByName(name);

        if (wayli != null) {
            _settings.wayli.remove(wayli);

            flush();
        }
    }

    public static function getAllWayli():Array<Wayli> {
        var outcome = [];
        for (w in _settings.wayli) {
            outcome.push({name: w.name, path: w.path});
        }
        return outcome;
    }

    public static function getWayliByName(name:String):Wayli {
        for (w in _settings.wayli) {
            if (w.name == name) {
                return w;
            }
        }
        return null;
    }

    static function initStorage() {
        FileSystem.createDirectory(STORAGE_PATH);

        flush();
    }

    static function flush() {
        var output = File.write(Path.join([STORAGE_PATH, SETTINGS_FILE]));
        output.writeString(Json.stringify(_settings == null ? EMPTY_SETTINGS : _settings));
        output.close();
    }

    static function get_settings():Settings {
        if (!isStorageExists) {
            initStorage();
        }
        if (_settings == null) {
            var bytes = File.getBytes(Path.join([STORAGE_PATH, SETTINGS_FILE]));
            _settings = Json.parse(bytes.toString());
        }
        return _settings;
    }

    static function get_isStorageExists():Bool {
        return FileSystem.exists(STORAGE_PATH);
    }

}
