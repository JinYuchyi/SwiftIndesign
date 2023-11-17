//
//  File.swift
//  
//
//  Created by Yuqi Jin on 11/6/23.
//

import Foundation

public struct IndesignItem {
    public var filePath: String
    public var editTime: Date
    public var layers: [IndesignLayer] = []
}

public struct IndesignLayer {
    public var layerId: String
    public var name: String
    public var locked: Bool
    public var visible: Bool
    public var items: [IndesignLayerItem] = []
}

public struct IndesignLayerItem {
    var type: IndesignLayerItemType
    var Locked: Bool
    var Visible: Bool
    var itemId: String
}

public enum IndesignLayerItemType {
    case TextType
    case Rectangle
    case Others
}


