//
//  File 2.swift
//  
//
//  Created by Yuqi Jin on 11/7/23.
//

import Foundation
import ZIPFoundation

class IdmlUtils {



    static func decompressIdmlToTemp(idml: String) -> URL? {
        guard let name = (idml.components(separatedBy: "/").last?.components(separatedBy: ".").dropLast())?.joined(separator: ".") else {
            print("Failed in getting idml name.")
            return nil
        }
        let targetFolder: URL = FileManager.default.temporaryDirectory.appendingPathComponent("SwiftIndesign", conformingTo: .directory).appendingPathComponent("Test", conformingTo: .directory).appendingPathComponent("\(name)", conformingTo: .directory)
        do {
            try FileManager.default.removeItem(at: targetFolder)
        } catch {
            print("\(error)")
        }
        do {
            try FileManager.default.createDirectory(at: targetFolder, withIntermediateDirectories: true)
        } catch {
            print("\(error)")
        }
        let source = URL(fileURLWithPath: "\(idml)")
        do {
            try FileManager.default.unzipItem(at: source, to: targetFolder)
            
        } catch {
            print("Extraction of ZIP archive failed with error:\(error)")
        }
        return targetFolder
    }
 




}
