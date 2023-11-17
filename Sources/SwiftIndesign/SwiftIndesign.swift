// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

class SwiftIndesign {

    var indesignItem: IndesignItem?

    init(inddPath: String) {
        // Try to find the idml with the same name in temp folder, the edit time should >= indd edit time
        // if cannot find it, convert indd to idml
        // Load design map
        if inddPath.hasSuffix("indd") == false {
            print("Error: the path \(inddPath) is not an .indd file.")
            return
        }
        let idml = inddPath.replacingOccurrences(of: ".indd", with: ".idml")
        if FileManager.default.fileExists(atPath: idml) == true {
            // If idml exist, compare the edit date for indd and idml
            if let idmlDate = FileUtils.getFileEditDate(path: idml),
               let inddDate = FileUtils.getFileEditDate(path: inddPath) {
                if idmlDate.distance(to: inddDate) > 0 {
                    // Regenerate idml
                    do {
                        try FileManager.default.removeItem(atPath: idml)
                    } catch {
                        print("Error: failed in deleting \(idml).")
                    }
                    let newIdml = InddUtils.convertToIdml(inddPath: inddPath)
                    if newIdml == nil {
                        print("Error: Cannot generate \(idml) from \(inddPath).")
                        return
                    }
                }
            }
        } else {
            let newIdml = InddUtils.convertToIdml(inddPath: inddPath)
            if newIdml == nil {
                print("Error: Cannot generate \(idml) from \(inddPath).")
                return
            }
        }

        // decompress
        if let decompressedFolder = IdmlUtils.decompressIdmlToTemp(idml: idml),
           let editDate = FileUtils.getFileEditDate(path: idml) {
            let designmapXml = decompressedFolder.appendingPathComponent("designmap", conformingTo: .xml)
            let parser = DesignmapXmlParser(path: designmapXml.path)
            indesignItem = IndesignItem(filePath: idml, editTime: editDate, layers: parser.layers)
        }
    }



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
        let script = AppleScript.getSetLayerPropertiesScript(fileList: fileList, layerIndexList: layerIndexList, visibleList: visibleList, lockList: lockList)
        let result = try? ScriptUtils.runShell(command: "osascript -e '\(script)'")
    }

}
