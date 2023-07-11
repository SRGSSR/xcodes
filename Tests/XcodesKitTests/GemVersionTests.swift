import XCTest
@testable import XcodesKit

final class GemVersionGemTests: XCTestCase {
    func test_Init() {
        let version = GemVersion(1, 2, 3, prereleaseIdentifiers: ["beta", "1"], rangeOperator: .lessThan)
        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 3)
        XCTAssertEqual(version.prereleaseIdentifiers, ["beta", "1"])
        XCTAssertEqual(version.rangeOperator, .lessThan)
    }

    func test_InitWithDefaultValues() {
        let version = GemVersion(1)
        XCTAssertEqual(version.major, 1)
        XCTAssertNil(version.minor)
        XCTAssertNil(version.patch)
        XCTAssertTrue(version.prereleaseIdentifiers.isEmpty)
        XCTAssertNil(version.rangeOperator)
    }

    func test_InitWithNegativeValues() {
        let version = GemVersion(-1, -2, -3)
        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 3)
    }
}
