//
//  File.swift
//  
//
//  Created by Yuqi Jin on 11/30/23.
//

import Foundation

extension String: Error {}
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
