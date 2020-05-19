#!/usr/bin/env xcrun swift

import Foundation

let cwd = FileManager.default.currentDirectoryPath
let script = CommandLine.arguments[0]

print("script run from: " + cwd)
print("\nfilepath given to script: " + script)

// Get script working dir
if script.hasPrefix("/") { //absolute
    let path = (script as NSString).deletingLastPathComponent
    
    print("\nscript at: " + path)
} else {
    let urlCwd = URL(fileURLWithPath: cwd)
    
    if let path = URL(string: script, relativeTo: urlCwd)?.path {
        let path = (path as NSString).deletingLastPathComponent
    
        print("\nscript at: " + path)
    }
}
