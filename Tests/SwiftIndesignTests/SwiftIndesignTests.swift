import XCTest
@testable import SwiftIndesign

final class SwiftIndesignTests: XCTestCase {

    func testAppleScriptIdesignConnection() throws {
        let result = SwiftIndesign.verifyIndesignConnection()
        XCTAssertTrue(result)
    }

    func testSetLayerProperties() throws {
        var fileList: [String] = ["/Users/jin/Documents/IndesignTest/826-11182-A_B520a_Single_Lang_FB_LBL_CH_1032789_v2.indd", "/Users/jin/Documents/IndesignTest/826-11832-A_N210_FB_Label_1Language_BTR_GEN_Single_1033547_v2.indd"]
        var layerIndexList: [Int] = [0, 1]
        var visibleList: [Bool] = [true, true]
        var lockList: [Bool] = [true, true]
        SwiftIndesign.setLayerProperties(fileList: fileList, layerIndexList: layerIndexList, visibleList: visibleList, lockList: lockList)
    }
}
