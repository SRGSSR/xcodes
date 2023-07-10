import Foundation
import Version

public extension VersionRequirement {
    init?(gemVersion: String) {
        let range = NSRange(gemVersion.startIndex..<gemVersion.endIndex, in: gemVersion)
        let operators = RangeOperator.allCases.map(\.rawValue).joined(separator: "|")
        let pattern = "^\\s*(?<operator>\(operators))?\\s*(?<major>\\d+)\\.?(?<minor>\\d?)?\\.?(?<patch>\\d?)?\\.?(?<prereleaseType>\\w?)?\\.?(?<prereleaseVersion>\\d?)"

        guard
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
            let match = regex.firstMatch(in: gemVersion, options: [], range: range),
            let majorString = match.groupNamed("major", in: gemVersion),
            let major = Int(majorString),
            let minorString = match.groupNamed("minor", in: gemVersion),
            let patchString = match.groupNamed("patch", in: gemVersion)
        else { return nil }

        let minor = Int(minorString)
        let patch = Int(patchString)
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

        if let rangeOperatorString = match.groupNamed("operator", in: gemVersion) {
            self = .init(
                major: major,
                minor: minor,
                patch: patch,
                prereleaseIdentifiers: prereleaseIdentifiers,
                rangeOperator: .init(rawValue: rangeOperatorString)
            )
        }
        else {
            self = .init(major: major, minor: minor, patch: patch, prereleaseIdentifiers: prereleaseIdentifiers)
        }
    }
}
