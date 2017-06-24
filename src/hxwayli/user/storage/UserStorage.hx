package hxwayli.user.storage;

import hxwayli.utils.PathUtils;
import haxe.Json;
import hxwayli.data.Settings;
import sys.io.File;
import sys.FileSystem;

using hxwayli.utils.PathUtils;

@:final
class UserStorage {

    static var EMPTY_SETTINGS:Settings = {version: "0.0.1", currentEnv: PathUtils.DEFAULT_ENV_PATH, envList: [], devlibList: []};

    public static var settings(get, never):Settings;
    public static var isStorageExists(get, never):Bool;

    static var _settings:Settings;

    public static function createEnv(name:String) {
        if (name != PathUtils.DEFAULT_ENV_PATH && !envExists(name)) {
            settings.envList.push(name);
            [PathUtils.STORAGE_PATH, name].joinPathes().createDirectory();

            flush();
        }
    }

    public static function removeEnv(name:String):Bool {
        if (name != PathUtils.DEFAULT_ENV_PATH && envExists(name)) {
            settings.envList.remove(name);

            flush();

            return true;
        }

        return false;
    }

    public static function envExists(name:String):Bool {
        return settings.envList.indexOf(name) >= 0 || name == PathUtils.DEFAULT_ENV_PATH;
    }

    public static function getEnvPath(name:String):String {
        return [name == PathUtils.DEFAULT_ENV_PATH ? PathUtils.HAXE_PATH : PathUtils.STORAGE_PATH, name].joinPathes();
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
        PathUtils.STORAGE_PATH.createDirectory();

        flush();
    }

    static function flush() {
        var output = File.write(PathUtils.SETTINGS_PATH);
        output.writeString(Json.stringify(_settings == null ? EMPTY_SETTINGS : _settings));
        output.close();
    }

    static function get_settings():Settings {
        if (!isStorageExists) {
            initStorage();
        }
        if (_settings == null) {
            var bytes = File.getBytes(PathUtils.SETTINGS_PATH);
            _settings = Json.parse(bytes.toString());
        }
        return _settings;
    }

    static function get_isStorageExists():Bool {
        return FileSystem.exists(PathUtils.STORAGE_PATH);
    }

}
