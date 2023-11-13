//
//  File.swift
//  
//
//  Created by Yuqi Jin on 10/24/23.
//

import Foundation
import Cocoa


class DesignmapXmlParser: NSObject, XMLParserDelegate {
    //当前元素名
    var currentElement = ""
    var layers: [IndesignLayer] = []
    private var currentLayer: IndesignLayer?

    init(path: String) {
        super.init()
        let url = URL(fileURLWithPath: path)
        guard let parser = XMLParser(contentsOf: url) else {
            return
        }
//        let xmlContent = FileManager.default.contents(atPath: url.path())
        parser.delegate = self
        parser.parse()
    }
 
    // 遇到一个开始标签时调用
    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {

        var _layer: IndesignLayer = IndesignLayer(layerId: "", name: "", locked: false, visible: false)
        if elementName == "Layer" {
            currentElement = elementName
            _layer.name = attributeDict["Name"] ?? ""
            _layer.locked = Bool(attributeDict["Locked"] ?? "false")!
            _layer.visible = Bool(attributeDict["Visible"] ?? "false")!
            _layer.layerId = (attributeDict["Self"] ?? "")!
            currentLayer = _layer
        }

        if elementName == "TextVariable" {
            let item = IndesignLayerItem(type: .TextType, Locked: Bool(attributeDict["Locked"] ?? "false")!, Visible: Bool(attributeDict["Visible"] ?? "false")!, itemId: (attributeDict["Self"] ?? "")!)
            _layer.items.append(item)
        }

        if elementName == "TextVariable" {
            let item = IndesignLayerItem(type: .TextType, Locked: Bool(attributeDict["Locked"] ?? "false")!, Visible: Bool(attributeDict["Visible"] ?? "false")!, itemId: (attributeDict["Self"] ?? "")!)
            _layer.items.append(item)
        }

//        print("elementName: \(elementName), namespaceURI: \(namespaceURI), qualifiedName: \(qName), attributes: \(attributeDict)")
    }

    // 遇到结束标签时调用
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //标签User结束时将该用户对象，存入数组容器。
        if elementName == "Layer" {
            if currentLayer != nil {
                layers.append(currentLayer!)
            }
        }
    }

}


