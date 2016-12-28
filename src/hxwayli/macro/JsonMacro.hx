package hxwayli.macro;

import haxe.macro.Context;
import haxe.Json;
import haxe.io.Bytes;
import sys.io.File;
import sys.FileSystem;

#if macro
import haxe.macro.Expr.ExprOf;
#end

@:final
class JsonMacro {

    macro public static function parseJson(path:String):ExprOf<{}> {
        var absolutePath:String = FileSystem.absolutePath(path);
        var bytes:Bytes = File.getBytes(absolutePath);

        return Context.makeExpr(Json.parse(bytes.toString()), Context.currentPos());
    }

}
