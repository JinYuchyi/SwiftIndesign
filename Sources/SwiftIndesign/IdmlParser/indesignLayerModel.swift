//
//  File.swift
//  
//
//  Created by Yuqi Jin on 11/6/23.
//

import Foundation

struct IndesignItem {
    var filePath: String
    var editTime: Date
    var layers: [IndesignLayer] = []
}

struct IndesignLayer {
    var layerId: String
    var name: String
    var locked: Bool
    var visible: Bool
    var items: [IndesignLayerItem] = []
}

struct IndesignLayerItem {
    var type: IndesignLayerItemType
    var Locked: Bool
    var Visible: Bool
    var itemId: String
}

enum IndesignLayerItemType {
    case TextType
    case Rectangle
    case Others
}


