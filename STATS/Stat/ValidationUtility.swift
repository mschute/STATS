import Foundation

struct ValidationUtility {
    static func moreThanOneDecimalPoint(value: String) -> Bool {
        return value.filter { $0 == "."}.count > 1
    }
    
    static func numberTooBig(value: String) -> Bool {
        if let dotIndex = value.firstIndex(of: ".") {
            let digitsBeforeDecimal = value.distance(from: value.startIndex, to: dotIndex)
            return digitsBeforeDecimal > 15
        } else {
            return false
        }
    }
}
