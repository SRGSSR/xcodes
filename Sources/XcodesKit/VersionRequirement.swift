import Foundation
import Version

extension Version {
    static var min: Self = .null
    static var max: Self = .init(.max, .max, .max)
}

public enum RangeOperator: String, CaseIterable {
    case greaterThanOrEqual = ">="
    case greaterThan = ">"
    case lessThanOrEqual = "<="
    case lessThan = "<"
    case tildeGreaterThan = "~>"
}

public struct VersionRequirement: Equatable {
    let minimumVersion: Version
    let maximumVersion: Version

    public init(
        major: Int,
        minor: Int? = nil,
        patch: Int? = nil,
        prereleaseIdentifiers: [String] = [],
        buildMetadataIdentifiers: [String] = [],
        rangeOperator: RangeOperator? = nil
    ) {
        switch rangeOperator {
        case nil:
            let version = Version(major, minor ?? 0, patch ?? 0, prereleaseIdentifiers: prereleaseIdentifiers, buildMetadataIdentifiers: buildMetadataIdentifiers)
            self.minimumVersion = version
            self.maximumVersion = version
        case .greaterThanOrEqual:
            self.minimumVersion = Version(major, minor ?? 0, patch ?? 0, prereleaseIdentifiers: prereleaseIdentifiers, buildMetadataIdentifiers: buildMetadataIdentifiers)
            self.maximumVersion = .max
        case .greaterThan:
            self.minimumVersion = Version(major, minor ?? 0, (patch ?? 0) + 1, prereleaseIdentifiers: prereleaseIdentifiers, buildMetadataIdentifiers: buildMetadataIdentifiers)
            self.maximumVersion = .max
        case .lessThanOrEqual:
            self.minimumVersion = .min
            self.maximumVersion = Version(major, minor ?? 0, patch ?? 0, prereleaseIdentifiers: prereleaseIdentifiers, buildMetadataIdentifiers: buildMetadataIdentifiers)
        case .lessThan:
            self.minimumVersion = .min
            if let patch, patch > 0 {
                self.maximumVersion = Version(major, minor ?? 0, patch - 1, prereleaseIdentifiers: prereleaseIdentifiers, buildMetadataIdentifiers: buildMetadataIdentifiers)
            }
            else if let minor, minor > 0 {
                self.maximumVersion = Version(major, minor - 1, .max, prereleaseIdentifiers: prereleaseIdentifiers, buildMetadataIdentifiers: buildMetadataIdentifiers)
            }
            else if major > 0 {
                self.maximumVersion = Version(major - 1, .max, .max, prereleaseIdentifiers: prereleaseIdentifiers, buildMetadataIdentifiers: buildMetadataIdentifiers)
            }
            else {
                self.maximumVersion = Version(.zero, .zero, .zero, prereleaseIdentifiers: prereleaseIdentifiers, buildMetadataIdentifiers: buildMetadataIdentifiers)
            }
        case .tildeGreaterThan:
            self.minimumVersion = Version(major, minor ?? 0, patch ?? 0, prereleaseIdentifiers: prereleaseIdentifiers, buildMetadataIdentifiers: buildMetadataIdentifiers)
            if minor == nil || patch == nil {
                self.maximumVersion = Version(major, .max, .max)
            }
            else {
                self.maximumVersion = Version(major, minor ?? 0, .max)
            }
        }
    }
}
