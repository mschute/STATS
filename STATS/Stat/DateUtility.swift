import Foundation

struct DateUtility {
    static func abbreviatedDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    static func startOfDay(date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    //To find end of day: https://www.reddit.com/r/swift/comments/16q6zrj/why_swift_didnt_provide/
    //Subtract 1 second: https://developer.apple.com/documentation/foundation/date/1948745-addingtimeinterval
    static func endOfDay(date: Date) -> Date {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        return calendar.date(byAdding: .day, value: 1, to: startOfDay)!.addingTimeInterval(-1)
    }
}
