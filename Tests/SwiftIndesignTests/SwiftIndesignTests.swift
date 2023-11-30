import XCTest
@testable import SwiftIndesign

final class SwiftIndesignTests: XCTestCase {

//    func testAppleScriptIdesignConnection() throws {
//        let result = SwiftIndesign.verifyIndesignConnection()
//        XCTAssertTrue(result)
//    }
//
//    func testInitSwiftIndesign() throws {
//        let swiftIndesign = SwiftIndesign(inddPath: "/Users/jin/Documents/IndesignTest/826-11832-A_N210_FB_Label_1Language_BTR_GEN_Single_1033547_v2.indd")
//        print(swiftIndesign.indesignItem)
//        XCTAssertTrue(swiftIndesign.indesignItem != nil)
//    }
//
//    func testSetLayerProperties() throws {
//        var fileList: [String] = ["/Users/jin/Documents/IndesignTest/826-11182-A_B520a_Single_Lang_FB_LBL_CH_1032789_v2.indd", "/Users/jin/Documents/IndesignTest/826-11832-A_N210_FB_Label_1Language_BTR_GEN_Single_1033547_v2.indd"]
//        var layerIndexList: [Int] = [0, 1]
//        var visibleList: [Bool] = [true, true]
//        var lockList: [Bool] = [false, true]
//        SwiftIndesign.setLayerProperties(fileList: fileList, layerIndexList: layerIndexList, visibleList: visibleList, lockList: lockList)
//    }

    func testUncompressFile() throws {
        var file = "/Users/jin/Downloads/PLK_Cicero_HIG_RainbowBeta_UG_O1_230501.zip"
        do {
            try FileManager.default.unzipItem(at: URL(fileURLWithPath: file), to: URL(fileURLWithPath: "/Users/jin/Desktop/test"))
            print("Finished")
        } catch {
            print("Extraction of ZIP archive failed with error:\(error)")
        }
    }

    func testUncompressIdml() throws {
        var idml: String = "/Users/jin/Downloads/Leverage/94254516/PLK_N199_TT_PAR_FL_O1_826-105xx/TransKit/DTK_N199_TT_PAR_FL_O1_826-105xx/import/826-10518-A_N199-A_FB_Label_BTR_PAR_B602_Single_1029124_v5.idml"

        guard let name = (idml.components(separatedBy: "/").last?.components(separatedBy: ".").dropLast())?.joined(separator: ".") else {
            print("Failed in getting idml name.")
            XCTAssert(false)
            return
        }
        let targetFolder: URL = FileManager.default.temporaryDirectory.appendingPathComponent("SwiftIndesign", conformingTo: .directory).appendingPathComponent("Test", conformingTo: .directory).appendingPathComponent("\(name)", conformingTo: .directory)
        do {
            try FileManager.default.removeItem(at: targetFolder)
        } catch {
            XCTAssert(false)
        }
        guard let path = IdmlUtils.decompressIdmlToTemp(idml: "\(idml)") else {
            XCTAssert(false)
            return
        }

        do {
            let contents = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: [])
            let xmls = contents.filter({$0.pathExtension == "xml"})
            XCTAssert(xmls.count > 0)
        } catch {
            XCTAssert(false)
        }
    }

    func testParseDesignmap() {
        let designMap = DesignmapXmlParser(path: "/private/var/folders/j_/3dzp0yqs74d8hnb1rq5wy_9r0000gn/T/SwiftIndesign/Test/designmap.xml")
        XCTAssertTrue(designMap.layers.count > 0)
    }

    func testStoryParser() {
        let story = StoryXmlParser(path: "/private/var/folders/j_/3dzp0yqs74d8hnb1rq5wy_9r0000gn/T/SwiftIndesign/Test/Stories/Story_u7e32.xml")
    }

    func testFileAttributes() throws {
        let date = FileUtils.getFileEditDate(path: "/Users/jin/Downloads/PLK_Cicero_HIG_RainbowBeta_UG_O1_230501.zip")
        XCTAssertTrue((date != nil))
//        print(attrs)
    }

    func testInddToIdml() throws {
        let indd = "/Users/jin/Documents/Development/SwiftIndesign/Tests/SwiftIndesignTests/test.indd"
        var targetIdmlPath = "/Users/jin/Downloads/123.idml"
        do {
            let path = try SwiftIndesign.Indesign.inddToIdml(indd: indd, targetPath: targetIdmlPath)
        } catch {
            print(error)
        }
    }


}
