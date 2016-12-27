package hxwayli.utils;

@:final
class ListExtensions {

    inline public static function addRange<T>(current:List<T>, from:List<T>):List<T> {
        for (item in from) {
            current.add(item);
        }
        return current;
    }

}
