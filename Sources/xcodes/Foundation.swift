import Foundation

extension BidirectionalCollection where Element: Equatable {
    func suffix(fromLast delimiter: Element) -> Self.SubSequence {
        guard 
            let lastIndex = lastIndex(of: delimiter),
            index(after: lastIndex) < endIndex
        else { return suffix(0) }
        return suffix(from: index(after: lastIndex))
    }
}

extension NumberFormatter {
    convenience init(numberStyle: NumberFormatter.Style) {
        self.init()
        self.numberStyle = numberStyle
    }

    func string<N: Numeric>(from number: N) -> String? {
        return string(from: number as! NSNumber)
    }
}