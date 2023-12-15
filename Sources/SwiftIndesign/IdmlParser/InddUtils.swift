//
//  File.swift
//  
//
//  Created by Yuqi Jin on 11/13/23.
//

import Foundation

class InddUtils {
    // If targetIdmlPath is nil, export to same path
    static func convertToIdml(inddPath: String, targetIdmlPath: String?, targetFolder: String?) {
        if targetIdmlPath == nil && targetFolder == nil {
            return
        }
        let script = AppleScript.saveToIdml(indd: inddPath, targetIdmlPath: targetIdmlPath, targetFolder: targetFolder)
        let scriptCmd = "osascript -e '\(script)'"
        #if DEBUG
        print(scriptCmd)
        #endif
        let _ = try? ScriptUtils.runShell(command: scriptCmd)
        return
    }


}
