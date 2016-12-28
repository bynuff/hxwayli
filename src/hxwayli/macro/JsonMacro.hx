package hxwayli.macro;

import sys.io.File;
import sys.FileSystem;

import haxe.Json;
import haxe.io.Bytes;

#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
#end

@:final
class JsonMacro {

    macro public static function parseJson(path:String):ExprOf<{}> {
        var absolutePath:String = FileSystem.absolutePath(path);
        var bytes:Bytes = File.getBytes(absolutePath);
        return Context.makeExpr(Json.parse(bytes.toString()), Context.currentPos());
    }

}
