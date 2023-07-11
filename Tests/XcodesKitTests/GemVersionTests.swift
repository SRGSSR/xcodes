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

    func test_InitFromStringWithMajor() {
        let version = GemVersion("1")!
        XCTAssertEqual(version.major, 1)
        XCTAssertNil(version.minor)
        XCTAssertNil(version.patch)
        XCTAssertTrue(version.prereleaseIdentifiers.isEmpty)
        XCTAssertNil(version.rangeOperator)
    }

    func test_InitFromStringWithMinor() {
        let version = GemVersion("1.2")!
        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertNil(version.patch)
        XCTAssertTrue(version.prereleaseIdentifiers.isEmpty)
        XCTAssertNil(version.rangeOperator)
    }

    func test_InitFromStringWithPatch() {
        let version = GemVersion("1.2.3")!
        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 3)
        XCTAssertTrue(version.prereleaseIdentifiers.isEmpty)
        XCTAssertNil(version.rangeOperator)
    }

    func test_InitFromAlphaString() {
        let version = GemVersion("1.2.3a4")!
        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 3)
        XCTAssertEqual(version.prereleaseIdentifiers, ["Alpha", "4"])
        XCTAssertNil(version.rangeOperator)
    }

    func test_InitFromBetaString() {
        let version = GemVersion("1.2.3b4")!
        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 3)
        XCTAssertEqual(version.prereleaseIdentifiers, ["Beta", "4"])
        XCTAssertNil(version.rangeOperator)
    }

    func test_InitFromOtherString() {
        let version = GemVersion("1.2.3c4")!
        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 3)
        XCTAssertEqual(version.prereleaseIdentifiers, ["c", "4"])
        XCTAssertNil(version.rangeOperator)
    }

    func test_InitFromStringWithOperator() {
        let version = GemVersion("~> 1.2.3")!
        XCTAssertEqual(version.major, 1)
        XCTAssertEqual(version.minor, 2)
        XCTAssertEqual(version.patch, 3)
        XCTAssertTrue(version.prereleaseIdentifiers.isEmpty)
        XCTAssertEqual(version.rangeOperator, .tildeGreaterThan)
    }

    func test_InitFailure() {
        XCTAssertNil(GemVersion("bad"))
    }

    func test_SpacesInInitFromStringAreIgnored() {
        XCTAssertEqual(GemVersion("  1.2.3  "), GemVersion("1.2.3"))
    }

    func test_SpacesInInitFromStringAreSuperfluous() {
        XCTAssertEqual(GemVersion("~>1.2.3"), GemVersion("~> 1.2.3"))
    }

    func test_SpacesInInitFromStringWithOperatorAreIgnored() {
        XCTAssertEqual(GemVersion("~>  1.2.3"), GemVersion("~> 1.2.3"))
    }
}
