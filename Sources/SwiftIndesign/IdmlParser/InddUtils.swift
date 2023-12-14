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

        }
        let script = AppleScript.saveToIdml(indd: inddPath, targetIdmlPath: targetIdmlPath, targetFolder: targetFolder)
        let _ = try? ScriptUtils.runShell(command: "osascript -e '\(script)'")
        return
    }


}
