//
//  File.swift
//  
//
//  Created by Yuqi Jin on 10/16/23.
//

import Foundation

class AppleScript {
    static let getIndesignInfo = """
    tell application id "com.adobe.indesign"
        set str to get properties
    end tell
    """

    static let getDocCount = """
    tell application id "com.adobe.indesign"
        documents count
    end tell
    """

    static func saveToIdml(indd: String) -> String {
        let script = """
    tell application id "com.adobe.InDesign"
        set myDoc to open "\(indd)"
        set oldName to name of myDoc
        set shortOldName to text 1 thru -6 of oldName
        set oldPath to the file path of myDoc
        set idmlPath to (oldPath as string) & shortOldName & ".idml"
        export myDoc format InDesign markup to file idmlPath
        close myDoc
    end tell
    """
        return script
    }

    static func getSetLayerPropertiesScript(fileList: [String], layerNameList: [String], visibleList: [Bool], lockList: [Bool], isContains: Bool) -> String {
        let fileListStr = fileList.map({"\"\($0)\""}).joined(separator: ",")
        let layerNameListStr = layerNameList.map({"\"\($0)\""}).joined(separator: ",")
        let visibleListStr = visibleList.map({String($0)}).joined(separator: ",")
        let lockListStr = lockList.map({String($0)}).joined(separator: ",")
        var conditionStr = "if the name of ly is equal to item i of layerNameList then"
        if isContains {
            conditionStr = "if the name of ly contains item i of layerNameList then"
        }
    let script = """
use framework "Foundation"
set fileList to {\(fileListStr)}
set layerNameList to {\(layerNameListStr)}
set lockSettingList to {\(lockListStr)}
set visibleSettingList to {\(visibleListStr)}

tell application id "com.adobe.InDesign"
    set user interaction level of script preferences to never interact
    activate
    repeat with filePath in fileList
        set myDocument to open filePath
        set _layers to layers of myDocument

        repeat with i from 1 to count layerNameList
            repeat with ly in _layers
                \(conditionStr)
                    set _visibleValue to the item i of visibleSettingList
                    set _lockValue to the item i of lockSettingList
                    set locked of ly to _lockValue
                    set visible of ly to _visibleValue
                end if
            end repeat
        end repeat

        save myDocument with force save

        set oldName to name of myDocument
        set shortOldName to text 1 thru -6 of oldName
        set oldPath to the file path of myDocument
        set idmlPath to (oldPath as string) & shortOldName & ".idml"
        export myDocument format InDesign markup to file idmlPath with force save

        close myDocument

    end repeat
end tell
"""
        print(script)
        return script
    }
}

