import XCTest
import Version
@testable import XcodesKit

class VersionRequirementTests: XCTestCase {
    func test_SingleVersion() {
        let requirement = VersionRequirement(gemVersion: "1.2.3")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: 3))
    }

    func test_SingleVersionWithIdentifiers() {
        let requirement = VersionRequirement(gemVersion: "1.2.3b4")!
        XCTAssertEqual(requirement.minimumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"]
        ))
        XCTAssertEqual(requirement.maximumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"]
        ))
    }

    func test_InitGreaterThanOrEqualToMajorVersion() {
        let requirement = VersionRequirement(gemVersion: ">= 1")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 0, patch: 0))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }

    func test_InitGreaterThanOrEqualToMinorVersion() {
        let requirement = VersionRequirement(gemVersion: ">= 1.2")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 0))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }

    func test_InitGreaterThanOrEqualToPatchVersion() {
        let requirement = VersionRequirement(gemVersion: ">= 1.2.3")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }

    func test_InitGreaterThanOrEqualToVersionWithIdentifiers() {
        let requirement = VersionRequirement(gemVersion: ">= 1.2.3b4")!
        XCTAssertEqual(requirement.minimumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"]
        ))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }

    func test_InitGreaterThanMajorVersion() {
        let requirement = VersionRequirement(gemVersion: "> 1")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 0, patch: 1))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }

    func test_InitGreaterThanMinorVersion() {
        let requirement = VersionRequirement(gemVersion: "> 1.2")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 1))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }

    func test_InitGreaterThanPatchVersion() {
        let requirement = VersionRequirement(gemVersion: "> 1.2.3")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 4))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }

    func test_InitGreaterThanVersionWithIdentifiers() {
        let requirement = VersionRequirement(gemVersion: "> 1.2.3b4")!
        XCTAssertEqual(requirement.minimumVersion, Version(
            major: 1,
            minor: 2,
            patch: 4,
            prereleaseIdentifiers: ["Beta", "4"]
        ))
        XCTAssertEqual(requirement.maximumVersion, .max)
    }

    func test_InitLessThanOrEqualToMajorVersion() {
        let requirement = VersionRequirement(gemVersion: "<= 1")!
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 0, patch: 0))
    }

    func test_InitLessThanOrEqualToMinorVersion() {
        let requirement = VersionRequirement(gemVersion: "<= 1.2")!
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: 0))
    }

    func test_InitLessThanOrEqualToPatchVersion() {
        let requirement = VersionRequirement(gemVersion: "<= 1.2.3")!
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: 3))
    }

    func test_InitLessThanOrEqualToVersionWithIdentifiers() {
        let requirement = VersionRequirement(gemVersion: "<= 1.2.3b4")!
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"]
        ))
    }

    func test_InitLessThanMajorVersion() {
        let requirement = VersionRequirement(gemVersion: "< 1")!
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 0, minor: .max, patch: .max))
    }

    func test_InitLessThanMinorVersion() {
        let requirement = VersionRequirement(gemVersion: "< 1.2")!
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 1, patch: .max))
    }

    func test_InitLessThanPatchVersion() {
        let requirement = VersionRequirement(gemVersion: "< 1.2.3")!
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: 2))
    }

    func test_InitLessThanVersionWithIdentifiers() {
        let requirement = VersionRequirement(gemVersion: "< 1.2.3b4")!
        XCTAssertEqual(requirement.minimumVersion, .min)
        XCTAssertEqual(requirement.maximumVersion, Version(
            major: 1,
            minor: 2,
            patch: 2,
            prereleaseIdentifiers: ["Beta", "4"]
        ))
    }

    func test_TildeGreaterThanMajorVersion() {
        let requirement = VersionRequirement(gemVersion: "~> 1")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 0, patch: 0))
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: .max, patch: .max))
    }

    func test_TildeGreaterThanMinorVersion() {
        let requirement = VersionRequirement(gemVersion: "~> 1.2")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 0))
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: .max, patch: .max))
    }

    func test_TildeGreaterThanPatchVersion() {
        let requirement = VersionRequirement(gemVersion: "~> 1.2.3")!
        XCTAssertEqual(requirement.minimumVersion, Version(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(requirement.maximumVersion, Version(major: 1, minor: 2, patch: .max))
    }

    func test_TildeGreaterThanVersionWithIdentifiers() {
        let requirement = VersionRequirement(gemVersion: "~> 1.2.3b4")!
        XCTAssertEqual(requirement.minimumVersion, Version(
            major: 1,
            minor: 2,
            patch: 3,
            prereleaseIdentifiers: ["Beta", "4"]
        ))
        XCTAssertEqual(requirement.maximumVersion, Version(
            major: 1,
            minor: 2,
            patch: .max,
            prereleaseIdentifiers: ["Beta", "4"]
        ))
    }

    func test_VersionLessThanZeroThrows() {
        XCTAssertNil(VersionRequirement(gemVersion: "< 0"))
    }

    func test_VersionLessThanOrEqualToZeroIsValid() {
        let requirement = VersionRequirement(gemVersion: "<= 0")!
        XCTAssertEqual(requirement.maximumVersion, .min)
        XCTAssertEqual(requirement.minimumVersion, .min)
    }

    func test_SpacesInVersionAreIgnored() {
        let requirement1 = VersionRequirement(gemVersion: "1.2.3")!
        let requirement2 = VersionRequirement(gemVersion: "  1.2.3  ")!
        XCTAssertEqual(requirement1, requirement2)
    }

    func test_SpacesInVersionWithOperatorAreSuperfluous() {
        let requirement1 = VersionRequirement(gemVersion: "~> 1.2.3")!
        let requirement2 = VersionRequirement(gemVersion: "~>1.2.3")!
        XCTAssertEqual(requirement1, requirement2)
    }

    func test_SpacesInVersionWithOperatorAreIgnored() {
        let requirement1 = VersionRequirement(gemVersion: "~> 1.2.3")!
        let requirement2 = VersionRequirement(gemVersion: "  ~>  1.2.3  ")!
        XCTAssertEqual(requirement1, requirement2)
    }
}
