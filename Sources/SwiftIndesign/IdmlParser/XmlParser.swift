//
//  File.swift
//  
//
//  Created by Yuqi Jin on 10/24/23.
//

import Foundation
import Cocoa

class XmlParser: NSObject, XMLParserDelegate {

    init(path: String) {
        super.init()
        let url = URL(string: path)!
        guard let parserXML = XMLParser(contentsOf: url) else {
            return
        }

        parserXML.delegate = self
        parserXML.parse()
    }

    func parserDidStartDocument(parser: XMLParser) {}

    func parserDidEndDocument(parser: XMLParser){}

    func parser(parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {}

    func parser(parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {}

    func parser(parser: XMLParser, var foundCharacters: String) {}

    func parser(parser: XMLParser, parseErrorOccurred parseError: NSError) {}
}
