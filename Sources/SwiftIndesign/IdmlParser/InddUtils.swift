//
//  File.swift
//  
//
//  Created by Yuqi Jin on 11/13/23.
//

import Foundation

class InddUtils {
    static func convertToIdml(inddPath: String) -> String? {
        let script = AppleScript.saveToIdml(indd: inddPath)
        let output = try? ScriptUtils.runShell(command: "osascript -e '\(script)'")

        let idml = inddPath.replacingOccurrences(of: ".indd", with: ".idml")
        if FileManager.default.fileExists(atPath: idml) {
            return idml
        }
        return nil
    }
}
