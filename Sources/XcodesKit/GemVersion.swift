import Foundation

public struct GemVersion: Hashable {
    /// The major version.
    public let major: Int
    
    /// The minor version.
    public let minor: Int?
    
    /// The patch version.
    public let patch: Int?
    
    /// The pre-release identifiers (if any).
    public let prereleaseIdentifiers: [String]
    
    /// The operator describing the range associated with the version.
    public let rangeOperator: RangeOperator?
    
    /**
     Create a version object.
     - Note: Integers are made absolute since negative integers are not allowed, yet it is conventional Swift to take `Int` over `UInt` where possible.
     - Remark: This initializer variant provided for more readable code when initializing with static integers.
     */
    @inlinable
    public init(_ major: Int, _ minor: Int? = nil, _ patch: Int? = nil, prereleaseIdentifiers: [String] = [], rangeOperator: RangeOperator? = nil) {
        self.major = abs(major)
        if let minor = minor {
            self.minor = abs(minor)
        }
        else {
            self.minor = nil
        }
        if let patch = patch {
            self.patch = abs(patch)
        }
        else {
            self.patch = nil
        }
        self.prereleaseIdentifiers = prereleaseIdentifiers
        self.rangeOperator = rangeOperator
    }

    public init?(_ string: String) {
        let range = NSRange(string.startIndex..<string.endIndex, in: string)
        let operators = RangeOperator.allCases.map(\.rawValue).joined(separator: "|")
        let pattern = "^\\s*(?<operator>\(operators))?\\s*(?<major>\\d+)\\.?(?<minor>\\d?)?\\.?(?<patch>\\d?)?\\.?(?<prereleaseType>\\w?)?\\.?(?<prereleaseVersion>\\d?)"

        guard
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
            let match = regex.firstMatch(in: string, options: [], range: range),
            let majorString = match.groupNamed("major", in: string),
            let major = Int(majorString),
            let minorString = match.groupNamed("minor", in: string),
            let patchString = match.groupNamed("patch", in: string)
        else { return nil }

        let minor = Int(minorString)
        let patch = Int(patchString)
        let prereleaseIdentifiers = [
            match.groupNamed("prereleaseType", in: string),
            match.groupNamed("prereleaseVersion", in: string)
        ].compactMap { $0 }
            .filter { !$0.isEmpty }
            .map { identifier -> String in
                switch identifier.lowercased() {
                case "a": return "Alpha"
                case "b": return "Beta"
                default: return identifier
                }
            }

        if let rangeOperatorString = match.groupNamed("operator", in: string) {
            self = .init(
                major,
                minor,
                patch,
                prereleaseIdentifiers: prereleaseIdentifiers,
                rangeOperator: .init(rawValue: rangeOperatorString)
            )
        }
        else {
            self = .init(major, minor, patch, prereleaseIdentifiers: prereleaseIdentifiers)
        }
    }
}
