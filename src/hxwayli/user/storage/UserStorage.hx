package hxwayli.user.storage;

import haxe.Json;
import hxwayli.data.Settings;
import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;

@:final
class UserStorage {

    static var DEFAULT_ENV:String = "lib";
    static var SETTINGS_FILE:String = "settings.json";
    static var STORAGE_PATH:String = ~/windows/i.match(Sys.systemName()) ? Path.join([Sys.getEnv("HAXEPATH"), "wayli", "local"]) : "~/wayli/local";
    static var EMPTY_SETTINGS:Settings = {version: "0.0.1", currentEnv: DEFAULT_ENV, envList: [], devlibList: []};

    public static var settings(get, never):Settings;
    public static var isStorageExists(get, never):Bool;

    static var _settings:Settings;

    public static function createEnv(name:String) {
        if (name != DEFAULT_ENV && !envExists(name)) {
            settings.envList.push(name);
            FileSystem.createDirectory(Path.join([STORAGE_PATH, name]));

            flush();
        }
    }

    public static function removeEnv(name:String):Bool {
        if (name != DEFAULT_ENV && envExists(name)) {
            settings.envList.remove(name);

            flush();

            return true;
        }

        return false;
    }

    public static function envExists(name:String):Bool {
        return settings.envList.indexOf(name) >= 0 || name == DEFAULT_ENV;
    }

    public static function getEnvPath(name:String):String {

        if (name == DEFAULT_ENV) {
            // TODO: refactor me
            if (~/windows/i.match(Sys.systemName())) {
                return Path.join([Sys.getEnv("HAXEPATH"), DEFAULT_ENV]);
            } else {
                // TODO: refactor me
                return Path.join(["/usr/local/lib/haxe", DEFAULT_ENV]);
            }
        }

        return Path.join([STORAGE_PATH, name]);
    }

    public static function registerDevlib(name:String, path:String) {
        if (devlibExists(name)) {
            return;
        }
        settings.devlibList.push({name: name, path: path});

        flush();
    }

    public static function removeDevlib(name:String) {
        if (!devlibExists(name, function(dl:Devlib) {
            settings.devlibList.remove(dl);
        })) {
            return;
        }

        flush();
    }

    public static function devlibExists(name:String, ?out:Devlib->Void):Bool {
        for (dl in settings.devlibList) {
            if (dl.name == name) {
                if (out != null) {
                    out(dl);
                }
                return true;
            }
        }
        return false;
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
