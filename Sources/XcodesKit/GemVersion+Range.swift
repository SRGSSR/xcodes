import Foundation
import Version

extension Version {
    static var min: Self = .null
    static var max: Self = .init(.max, .max, .max)
}

public extension GemVersion {
    /// The minimum compatible version.
    var minimumVersion: Version {
        switch rangeOperator {
        case nil, .greaterThanOrEqual, .tildeGreaterThan:
            return Version(major, minor ?? 0, patch ?? 0, prereleaseIdentifiers: prereleaseIdentifiers)
        case .greaterThan:
            return Version(major, minor ?? 0, (patch ?? 0) + 1, prereleaseIdentifiers: prereleaseIdentifiers)
        case .lessThanOrEqual, .lessThan:
            return .min
        }
    }

    /// The maximum compatible version.
    var maximumVersion: Version {
        switch rangeOperator {
        case nil, .lessThanOrEqual:
            return Version(major, minor ?? 0, patch ?? 0, prereleaseIdentifiers: prereleaseIdentifiers)
        case .greaterThanOrEqual, .greaterThan:
            return .max
        case .lessThan:
            if let patch = patch, patch > 0 {
                return Version(major, minor ?? 0, patch - 1, prereleaseIdentifiers: prereleaseIdentifiers)
            }
            else if let minor = minor, minor > 0 {
                return Version(major, minor - 1, .max, prereleaseIdentifiers: prereleaseIdentifiers)
            }
            else if major > 0 {
                return Version(major - 1, .max, .max, prereleaseIdentifiers: prereleaseIdentifiers)
            }
            else {
                return Version(.zero, .zero, .zero, prereleaseIdentifiers: prereleaseIdentifiers)
            }
        case .tildeGreaterThan:
            if minor == nil || patch == nil {
                return Version(major, .max, .max)
            }
            else {
                return Version(major, minor ?? 0, .max)
            }
        }
    }
}
