//
//  File.swift
//  
//
//  Created by Yuqi Jin on 11/13/23.
//

import Foundation

class InddUtils {
    // If targetIdmlPath is nil, export to same path
    static func convertToIdml(inddPath: String, targetIdmlPath: String?) {
        if targetIdmlPath?.hasSuffix("idml") == false {
            return
        }
        let script = AppleScript.saveToIdml(indd: inddPath, targetIdmlPath: targetIdmlPath)
        let _ = try? ScriptUtils.runShell(command: "osascript -e '\(script)'")
        return
    }
}
