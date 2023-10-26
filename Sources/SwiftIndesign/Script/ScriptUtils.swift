//
//  File.swift
//
//
//  Created by Yuqi Jin on 10/16/23.
//

import Foundation


class ScriptUtils {

    static func runShell(title: String = "SwiftIndesign", command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()
        var environment = ProcessInfo.processInfo.environment
        environment["PATH"] = "/opt/homebrew/Caskroom/miniforge/base/bin:/opt/homebrew/Caskroom/miniforge/base/condabin:/opt/local/bin:/opt/local/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/opt/homwbrew/bin"
        //:/opt/homebrew/Caskroom/miniforge/base/condabin:/opt/homebrew/bin"
        task.environment = environment
        task.standardOutput = pipe
        task.standardError = pipe

        let _cmd = command

        task.arguments = ["-c", _cmd]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh") //<--updated

        do {
            try task.run()
        }
        catch{
            print("Running shell command failed. \(error)")
            throw error
        }
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""
        return output
    }
}
