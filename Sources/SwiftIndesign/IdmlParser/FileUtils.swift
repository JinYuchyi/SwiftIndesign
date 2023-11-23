//
//  File.swift
//  
//
//  Created by Yuqi Jin on 11/7/23.
//

import Foundation

class FileUtils {
    static func getFileEditDate(path: String) -> Date? {
        if FileManager.default.fileExists(atPath: path) == false {return nil}
        do {
            let attrs = try FileManager.default.attributesOfItem(atPath: path)
            return attrs[.modificationDate] as? Date
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
