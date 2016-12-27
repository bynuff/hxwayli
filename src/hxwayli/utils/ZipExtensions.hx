package hxwayli.utils;

import sys.io.FileOutput;
import haxe.zip.Writer;
import haxe.io.BytesOutput;
import sys.FileSystem;
import haxe.crypto.Crc32;
import haxe.io.Bytes;
import haxe.io.Path;
import sys.io.File;
import haxe.zip.Entry;

using hxwayli.utils.ListExtensions;

@:final
class ZipExtensions {

    public static function createEntry(currentPath:String, targetPath:String):Entry {
        if (FileSystem.exists(currentPath)) {
            var bytes:Bytes = File.getBytes(currentPath);
            return {
                fileName: targetPath,
                fileSize: bytes.length,
                fileTime: Date.now(),
                compressed: false,
                dataSize: 0,
                data: bytes,
                crc32: Crc32.make(bytes),
                extraFields: null
            }
        }
        throw 'File $currentPath does not exist.';
    }

    public static function createEntries(currentPath:String, targetPath:String):List<Entry> {
        if (!FileSystem.exists(currentPath)) {
            throw 'Path $currentPath does not exist.';
        }
        var entryList:List<Entry> = new List<Entry>();

        if (FileSystem.isDirectory(currentPath)) {
            for (subPath in FileSystem.readDirectory(currentPath)) {
                entryList.addRange(
                    createEntries(
                        Path.join([currentPath, subPath]),
                        Path.join([targetPath, subPath])
                    )
                );
            }
        } else {
            entryList.add(createEntry(currentPath, targetPath));
        }
        return entryList;
    }

    public static function makeZipPackage(entries:List<Entry>, targetPath:String) {
        var bytesOutput:BytesOutput = new BytesOutput();
        var writer:Writer = new Writer(bytesOutput);

        writer.write(entries);

        var bytes:Bytes = bytesOutput.getBytes();
        var fileOutput:FileOutput = File.write(targetPath);

        fileOutput.write(bytes);
        fileOutput.close();
    }

}
