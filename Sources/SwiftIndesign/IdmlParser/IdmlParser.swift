//
//  File.swift
//  
//
//  Created by Yuqi Jin on 10/20/23.
//

import Foundation
import Cocoa
import ZIPFoundation

struct IdmlParser {

    init(path: String) throws {
        if let idmlFileName = path.components(separatedBy: "/").last {
            if idmlFileName.contains(".idml") == false {
                throw SwiftIndesignError.error("The directory is not an idml file:\n \(path).")
            }
            if FileManager.default.fileExists(atPath: path) == false {
                throw SwiftIndesignError.error("The directory is not exist:\n \(path).")
            }

            let sourceUrl = URL(fileURLWithPath: path)
            let targetUrl = FileManager.default.temporaryDirectory.appendingPathComponent(idmlFileName, conformingTo: .directory)
            decompressFile(sourceZip: sourceUrl, targetFolder: targetUrl)
        }
    }

    private func decompressFile(sourceZip: URL, targetFolder: URL) {
        do {
            try FileManager.default.unzipItem(at: sourceZip, to: targetFolder)
        } catch {
            print("Extraction of ZIP archive failed with error:\(error)")
        }
    }
}
