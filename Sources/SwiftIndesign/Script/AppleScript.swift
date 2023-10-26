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

    static func getSetLayerPropertiesScript(fileList: [String], layerIndexList: [Int], visibleList: [Bool], lockList: [Bool]) -> String {
        let fileListStr = fileList.map({"\"\($0)\""}).joined(separator: ",")
        let layerIndexListStr = layerIndexList.map({String($0)}).joined(separator: ",")
        let visibleListStr = visibleList.map({String($0)}).joined(separator: ",")
        let lockListStr = lockList.map({String($0)}).joined(separator: ",")
    let script = """
use framework "Foundation"
set fileList to {\(fileListStr)}
set lockSettingTargetList to {\(layerIndexListStr)}
set lockSettingList to {\(lockListStr)}
set visibleSettingTargetList to {\(layerIndexListStr)}
set visibleSettingList to {\(visibleListStr)}

tell application id "com.adobe.InDesign"
    set user interaction level of script preferences to never interact
    activate
    repeat with filePath in fileList
        set myDocument to open filePath
        set _layers to layers of myDocument
        repeat with i from 1 to count lockSettingTargetList
            set _layerIndex to item i of lockSettingTargetList
            set _layer to the item (_layerIndex + 1) of _layers
            set _lockValue to the item i of lockSettingList
            set locked of _layer to _lockValue
        end repeat

        repeat with i from 1 to count visibleSettingTargetList
            set _layerIndex to item i of visibleSettingTargetList
            set _layer to the item (_layerIndex + 1) of _layers
            set _visibleValue to the item i of visibleSettingList
            set visible of _layer to _visibleValue
        end repeat

        save myDocument
        close myDocument
    end repeat
end tell
"""
        return script
    }
}

