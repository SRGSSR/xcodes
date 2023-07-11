import Foundation

/// Describes the range associated with a version.
public enum RangeOperator: String, CaseIterable {
    case greaterThanOrEqual = ">="
    case greaterThan = ">"
    case lessThanOrEqual = "<="
    case lessThan = "<"
    case tildeGreaterThan = "~>"
}
