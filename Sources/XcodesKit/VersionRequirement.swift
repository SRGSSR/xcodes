import Foundation
import Version

extension Version {
    static var min: Self = .null
    static var max: Self = .init(.max, .max, .max)
}

public struct VersionRequirement: Equatable {
    let minimumVersion: Version
    let maximumVersion: Version

    public init?(gemVersion: String) {
        let range = NSRange(gemVersion.startIndex..<gemVersion.endIndex, in: gemVersion)
        let pattern = "^\\s*(?<operator><|<=|>|>=|~>)?\\s*(?<major>\\d+)\\.?(?<minor>\\d?)?\\.?(?<patch>\\d?)?\\.?(?<prereleaseType>\\w?)?\\.?(?<prereleaseVersion>\\d?)"

        guard
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
            let match = regex.firstMatch(in: gemVersion, options: [], range: range),
            let majorString = match.groupNamed("major", in: gemVersion),
            let major = Int(majorString),
            let minorString = match.groupNamed("minor", in: gemVersion),
            let patchString = match.groupNamed("patch", in: gemVersion)
        else { return nil }

        let `operator` = match.groupNamed("operator", in: gemVersion)
        let minor = Int(minorString) ?? 0
        let patch = Int(patchString) ?? 0
        let prereleaseIdentifiers = [
            match.groupNamed("prereleaseType", in: gemVersion),
            match.groupNamed("prereleaseVersion", in: gemVersion)
        ].compactMap { $0 }
            .filter { !$0.isEmpty }
            .map { identifier -> String in
                switch identifier.lowercased() {
                case "a": return "Alpha"
                case "b": return "Beta"
                default: return identifier
                }
            }
        switch `operator` {
        case nil:
            let version = Version(major, minor, patch, prereleaseIdentifiers: prereleaseIdentifiers)
            self.minimumVersion = version
            self.maximumVersion = version
        case ">=":
            self.minimumVersion = Version(major, minor, patch, prereleaseIdentifiers: prereleaseIdentifiers)
            self.maximumVersion = .max
        case ">":
            self.minimumVersion = Version(major, minor, patch + 1, prereleaseIdentifiers: prereleaseIdentifiers)
            self.maximumVersion = .max
        case "<=":
            self.minimumVersion = .min
            self.maximumVersion = Version(major, minor, patch, prereleaseIdentifiers: prereleaseIdentifiers)
        case "<":
            self.minimumVersion = .min
            if patch > 0 {
                self.maximumVersion = Version(major, minor, patch - 1, prereleaseIdentifiers: prereleaseIdentifiers)
            }
            else if minor > 0 {
                self.maximumVersion = Version(major, minor - 1, .max, prereleaseIdentifiers: prereleaseIdentifiers)
            }
            else if major > 0 {
                self.maximumVersion = Version(major - 1, .max, .max, prereleaseIdentifiers: prereleaseIdentifiers)
            }
            else {
                return nil
            }
        case "~>":
            self.minimumVersion = Version(major, minor, patch, prereleaseIdentifiers: prereleaseIdentifiers)
            if minorString.isEmpty || patchString.isEmpty {
                self.maximumVersion = Version(major, .max, .max, prereleaseIdentifiers: prereleaseIdentifiers)
            }
            else {
                self.maximumVersion = Version(major, minor, .max, prereleaseIdentifiers: prereleaseIdentifiers)
            }
        default:
            return nil
        }
    }
}
