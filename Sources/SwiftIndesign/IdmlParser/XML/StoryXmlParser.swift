//
//  File 2.swift
//  
//
//  Created by Yuqi Jin on 11/6/23.
//

import Foundation


class StoryXmlParser: NSObject, XMLParserDelegate {
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
//        if elementName == "Layer" {
//            currentElement = elementName
//            let _name = attributeDict["Name"] ?? ""
//            let _locked = Bool(attributeDict["Locked"] ?? "false")!
//            let _visible = Bool(attributeDict["Visible"] ?? "false")!
//            let _idStr = (attributeDict["Self"] ?? "")!
//            let _layer = IndesignLayer(layerId: _idStr, name: _name, locked: _locked, visible: _visible)
//            currentLayer = _layer
//        }
        print("elementName: \(elementName), namespaceURI: \(namespaceURI), qualifiedName: \(qName), attributes: \(attributeDict)")
    }

    // 遇到结束标签时调用
//    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        //标签User结束时将该用户对象，存入数组容器。
////        if elementName == "Layer" {
////            if currentLayer != nil {
////                layers.append(currentLayer!)
////            }
////        }
//    }

//    func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String) {
//        print(print)
//    }
}
