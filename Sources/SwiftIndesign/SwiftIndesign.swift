// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

class SwiftIndesign {
    static func verifyIndesignConnection() -> Bool {
        do {
            let output = try ScriptUtils.runShell(command: "osascript -e '\(AppleScript.getIndesignInfo)'")
            if output.contains("full name:file Macintosh HD") {
                return true
            }
        } catch {
            print("\(error)")
            return false
        }
        return false
    }

    static func getDocCount() -> Int? {
        do {
            let output = try ScriptUtils.runShell(command: "osascript -e '\(AppleScript.getDocCount)'")
            print(output)
        } catch {
            print("\(error)")
            return nil
        }
        return nil
    }

    static func setLayerProperties(fileList: [String], layerIndexList: [Int], visibleList: [Bool], lockList: [Bool] ) {
        let fileListStr = fileList.map({"\"\($0)\""}).joined(separator: ",")
        let layerIndexListStr = layerIndexList.map({String($0)}).joined(separator: ",")
        let visibleListStr = visibleList.map({String($0)}).joined(separator: ",")
        let lockListStr = lockList.map({String($0)}).joined(separator: ",")
        let script = AppleScript.getSetLayerPropertiesScript(fileList: fileList, layerIndexList: layerIndexList, visibleList: visibleList, lockList: lockList)
        _ = try? ScriptUtils.runShell(command: script)
    }

    
}
