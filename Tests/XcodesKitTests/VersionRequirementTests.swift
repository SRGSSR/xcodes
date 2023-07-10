import XCTest
import Version
@testable import XcodesKit

final class VersionRequirementTests: XCTestCase {
    func test_SingleVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, patch: 3)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: 3))
    }
    
    func test_SingleVersionWithIdentifiers() {
        let requirement = VersionRequirement(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"]
        )
        XCTAssertEqual(requirement.minimumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"]
        ))
        XCTAssertEqual(requirement.maximumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"]
        ))
    }
    
    func test_InitGreaterThanOrEqualToMajorVersion() {
        let requirement = VersionRequirement(major: 1, rangeOperator: .greaterThanOrEqual)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 0, patch: 0))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }
    
    func test_InitGreaterThanOrEqualToMinorVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, rangeOperator: .greaterThanOrEqual)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 0))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }
    
    func test_InitGreaterThanOrEqualToPatchVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, patch: 3, rangeOperator: .greaterThanOrEqual)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }
    
    func test_InitGreaterThanOrEqualToVersionWithIdentifiers() {
        let requirement = VersionRequirement(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"],
            rangeOperator: .greaterThanOrEqual
        )
        XCTAssertEqual(requirement.minimumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"]
        ))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }
    
    func test_InitGreaterThanMajorVersion() {
        let requirement = VersionRequirement(major: 1, rangeOperator: .greaterThan)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 0, patch: 1))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }
    
    func test_InitGreaterThanMinorVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, rangeOperator: .greaterThan)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 1))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }
    
    func test_InitGreaterThanPatchVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, patch: 3, rangeOperator: .greaterThan)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 4))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }
    
    func test_InitGreaterThanVersionWithIdentifiers() {
        let requirement = VersionRequirement(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"],
            rangeOperator: .greaterThan
        )
        XCTAssertEqual(requirement.minimumVersion, Version(
            major: 1,
            minor: 2,
            patch: 4,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"]
        ))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }
    
    func test_InitLessThanOrEqualToMajorVersion() {
        let requirement = VersionRequirement(major: 1, rangeOperator: .lessThanOrEqual)
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 0, patch: 0))
    }
    
    func test_InitLessThanOrEqualToMinorVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, rangeOperator: .lessThanOrEqual)
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: 0))
    }
    
    func test_InitLessThanOrEqualToPatchVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, patch: 3, rangeOperator: .lessThanOrEqual)
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: 3))
    }
    
    func test_InitLessThanOrEqualToVersionWithIdentifiers() {
        let requirement = VersionRequirement(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"],
            rangeOperator: .lessThanOrEqual
        )
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"]
        ))
    }
    
    func test_InitLessThanMajorVersion() {
        let requirement = VersionRequirement(major: 1, rangeOperator: .lessThan)
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 0, minor: .max, patch: .max))
    }
    
    func test_InitLessThanMinorVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, rangeOperator: .lessThan)
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 1, patch: .max))
    }
    
    func test_InitLessThanPatchVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, patch: 3, rangeOperator: .lessThan)
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: 2))
    }
    
    func test_InitLessThanVersionWithIdentifiers() {
        let requirement = VersionRequirement(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"],
            rangeOperator: .lessThan
        )
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(
            major: 1,
            minor: 2,
            patch: 2,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"]
        ))
    }
    
    func test_TildeGreaterThanMajorVersion() {
        let requirement = VersionRequirement(major: 1, rangeOperator: .tildeGreaterThan)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 0, patch: 0))
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: .max, patch: .max))
    }
    
    func test_TildeGreaterThanMinorVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, rangeOperator: .tildeGreaterThan)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 0))
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: .max, patch: .max))
    }
    
    func test_TildeGreaterThanPatchVersion() {
        let requirement = VersionRequirement(major: 1, minor: 2, patch: 3, rangeOperator: .tildeGreaterThan)
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: .max))
    }
    
    func test_TildeGreaterThanVersionWithIdentifiers() {
        let requirement = VersionRequirement(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"],
            rangeOperator: .tildeGreaterThan
        )
        XCTAssertEqual(requirement.minimumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"],
            buildMetadataIdentifiers: ["Build", "5"]
        ))
        XCTAssertEqual(requirement.maximumVersion, Version(
            major: 1,
            minor: 2,
            patch: .max
        ))
    }
    
    func test_VersionLessThanZeroIsRoundedToZero() {
        let requirement = VersionRequirement(major: 0, rangeOperator: .lessThan)
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, .min)
    }
    
    func test_VersionLessThanOrEqualToZeroIsValid() {
        let requirement = VersionRequirement(major: 0, rangeOperator: .lessThanOrEqual)
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, .min)
    }
}
