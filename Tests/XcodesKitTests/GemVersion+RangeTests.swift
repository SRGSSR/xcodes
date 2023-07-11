import XCTest
import Version
@testable import XcodesKit

final class GemVersionRangeTests: XCTestCase {
    func test_SingleVersion() {
        let version = GemVersion(1, 2, 3)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(version.maximumVersion, Version(major: 1, minor: 2, patch: 3))
    }
    
    func test_SingleVersionWithIdentifiers() {
        let version = GemVersion(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"])
        XCTAssertEqual(version.minimumVersion, Version(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"]))
        XCTAssertEqual(version.maximumVersion, Version(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"]))
    }
    
    func test_InitGreaterThanOrEqualToMajorVersion() {
        let version = GemVersion(1, rangeOperator: .greaterThanOrEqual)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 0, patch: 0))
        XCTAssertEqual(version.maximumVersion, .max)
    }
    
    func test_InitGreaterThanOrEqualToMinorVersion() {
        let version = GemVersion(1, 2, rangeOperator: .greaterThanOrEqual)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 2, patch: 0))
        XCTAssertEqual(version.maximumVersion, .max)
    }
    
    func test_InitGreaterThanOrEqualToPatchVersion() {
        let version = GemVersion(1, 2, 3, rangeOperator: .greaterThanOrEqual)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(version.maximumVersion, .max)
    }
    
    func test_InitGreaterThanOrEqualToVersionWithIdentifiers() {
        let version = GemVersion(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"], rangeOperator: .greaterThanOrEqual)
        XCTAssertEqual(version.minimumVersion, Version(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"]))
        XCTAssertEqual(version.maximumVersion, .max)
    }
    
    func test_InitGreaterThanMajorVersion() {
        let version = GemVersion(1, rangeOperator: .greaterThan)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 0, patch: 1))
        XCTAssertEqual(version.maximumVersion, .max)
    }
    
    func test_InitGreaterThanMinorVersion() {
        let version = GemVersion(1, 2, rangeOperator: .greaterThan)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 2, patch: 1))
        XCTAssertEqual(version.maximumVersion, .max)
    }
    
    func test_InitGreaterThanPatchVersion() {
        let version = GemVersion(1, 2, 3, rangeOperator: .greaterThan)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 2, patch: 4))
        XCTAssertEqual(version.maximumVersion, .max)
    }
    
    func test_InitGreaterThanVersionWithIdentifiers() {
        let version = GemVersion(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"], rangeOperator: .greaterThan)
        XCTAssertEqual(version.minimumVersion, Version(1, 2, 4, prereleaseIdentifiers: ["Beta", "4"]))
        XCTAssertEqual(version.maximumVersion, .max)
    }
    
    func test_InitLessThanOrEqualToMajorVersion() {
        let version = GemVersion(1, rangeOperator: .lessThanOrEqual)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, Version(major: 1, minor: 0, patch: 0))
    }
    
    func test_InitLessThanOrEqualToMinorVersion() {
        let version = GemVersion(1, 2, rangeOperator: .lessThanOrEqual)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, Version(major: 1, minor: 2, patch: 0))
    }
    
    func test_InitLessThanOrEqualToPatchVersion() {
        let version = GemVersion(1, 2, 3, rangeOperator: .lessThanOrEqual)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, Version(major: 1, minor: 2, patch: 3))
    }
    
    func test_InitLessThanOrEqualToVersionWithIdentifiers() {
        let version = GemVersion(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"], rangeOperator: .lessThanOrEqual)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, Version(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"]))
    }
    
    func test_InitLessThanMajorVersion() {
        let version = GemVersion(1, rangeOperator: .lessThan)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, Version(major: 0, minor: .max, patch: .max))
    }
    
    func test_InitLessThanMinorVersion() {
        let version = GemVersion(1, 2, rangeOperator: .lessThan)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, Version(major: 1, minor: 1, patch: .max))
    }
    
    func test_InitLessThanPatchVersion() {
        let version = GemVersion(1, 2, 3, rangeOperator: .lessThan)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, Version(major: 1, minor: 2, patch: 2))
    }
    
    func test_InitLessThanVersionWithIdentifiers() {
        let version = GemVersion(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"], rangeOperator: .lessThan)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, Version(1, 2, 2, prereleaseIdentifiers: ["Beta", "4"]))
    }
    
    func test_TildeGreaterThanMajorVersion() {
        let version = GemVersion(1, rangeOperator: .tildeGreaterThan)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 0, patch: 0))
        XCTAssertEqual(version.maximumVersion, Version(major: 1, minor: .max, patch: .max))
    }
    
    func test_TildeGreaterThanMinorVersion() {
        let version = GemVersion(1, 2, rangeOperator: .tildeGreaterThan)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 2, patch: 0))
        XCTAssertEqual(version.maximumVersion, Version(major: 1, minor: .max, patch: .max))
    }
    
    func test_TildeGreaterThanPatchVersion() {
        let version = GemVersion(1, 2, 3, rangeOperator: .tildeGreaterThan)
        XCTAssertEqual(version.minimumVersion, Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(version.maximumVersion, Version(major: 1, minor: 2, patch: .max))
    }
    
    func test_TildeGreaterThanVersionWithIdentifiers() {
        let version = GemVersion(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"], rangeOperator: .tildeGreaterThan)
        XCTAssertEqual(version.minimumVersion, Version(1, 2, 3, prereleaseIdentifiers: ["Beta", "4"]))
        XCTAssertEqual(version.maximumVersion, Version(1, 2, .max))
    }
    
    func test_VersionLessThanZeroIsRoundedToZero() {
        let version = GemVersion(0, rangeOperator: .lessThan)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, .min)
    }
    
    func test_VersionLessThanOrEqualToZeroIsValid() {
        let version = GemVersion(0, rangeOperator: .lessThanOrEqual)
        XCTAssertEqual(version.minimumVersion, .min)
        XCTAssertEqual(version.maximumVersion, .min)
    }
}
