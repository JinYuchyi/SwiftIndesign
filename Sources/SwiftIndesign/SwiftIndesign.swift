// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class Indesign {

//    private var indesignItem: IndesignItem?
//    private var indd: String?

    public init() {
//        if inddPath.hasSuffix("indd") == false {
//            print("Error: the path \(inddPath) is not an .indd file.")
//            return
//        } else {
//            indd = inddPath
//        }
    }

    public static func getIndesign(inddPath: String) -> IndesignItem? {
        // Try to find the idml with the same name in temp folder, the edit time should >= indd edit time
        // if cannot find it, convert indd to idml
        // Load design map

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
                    let _ = InddUtils.convertToIdml(inddPath: inddPath, targetIdmlPath: nil)
                }
            }
        } else {
            let _ = InddUtils.convertToIdml(inddPath: inddPath, targetIdmlPath: nil)
        }

        // decompress
        if let decompressedFolder = IdmlUtils.decompressIdmlToTemp(idml: idml),
           let editDate = FileUtils.getFileEditDate(path: idml) {
            let designmapXml = decompressedFolder.appendingPathComponent("designmap", conformingTo: .xml)
            let parser = DesignmapXmlParser(path: designmapXml.path)
            let indesignItem = IndesignItem(filePath: idml, editTime: editDate, layers: parser.layers)
            return indesignItem
        }
        return nil
    }


    public static func verifyIndesignConnection() -> Bool {
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

    public static func getDocCount() -> Int? {
        do {
            let output = try ScriptUtils.runShell(command: "osascript -e '\(AppleScript.getDocCount)'")
            print(output)
        } catch {
            print("\(error)")
            return nil
        }
        return nil
    }


    public static func setLayerProperties(fileList: [String], targetLayerNameList: [String], visibleList: [Bool], lockList: [Bool], isContains: Bool ) -> String {
        var script = ""
        if targetLayerNameList.filter({$0.isEmpty == false}).count > 0 {
            script = AppleScript.getSetLayerPropertiesScript(fileList: fileList, layerNameList: targetLayerNameList, visibleList: visibleList, lockList: lockList, isContains: isContains)
        } else {
            script = AppleScript.getSetForAllLayersScript(fileList: fileList, visible: visibleList[0], lock: lockList[0])
        }
        let result = try? ScriptUtils.runShell(command: "osascript -e '\(script)'")
        return result ?? ""
    }

    public static func setAllLayersPropertities(fileList: [String], visible: Bool, lock: Bool ) -> String {
        let script = AppleScript.getSetForAllLayersScript(fileList: fileList, visible: visible, lock: lock)
        let result = try? ScriptUtils.runShell(command: "osascript -e '\(script)'")
        return result ?? ""
    }

    public static func inddToIdml(indd: String, targetPath: String) throws -> String {
        var isDir: ObjCBool = false

        var targetIdmlPath = targetPath
        if FileManager.default.fileExists(atPath: targetPath, isDirectory: &isDir) {
            if isDir.boolValue == true {
                guard let inddName = indd.components(separatedBy: "/").last else {
                    throw ("Cannot get file name from \(indd).")
                }
                targetIdmlPath = targetPath + "/" + inddName.replacingOccurrences(of: ".indd", with: ".idml")
            } else {
                if targetIdmlPath.hasSuffix("idml") == false {
                    throw ("\(targetPath) is neither a idml file or a directory.")
                }
            }
        }
        let _ = InddUtils.convertToIdml(inddPath: indd, targetIdmlPath: targetIdmlPath)  
        return targetIdmlPath
    }

}
