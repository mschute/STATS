import Foundation

class ReportUtility {
    
    static func calcTotalEntries(stat: any Stat, startDate: Date, endDate: Date) -> Int {
        if(stat.statEntry.isEmpty) {
            return 0
        }
        var count = 0
        
        for entry in stat.statEntry {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                count += 1
            }
        }
        return count
    }
    
    //Implementation: https://sarunw.com/posts/getting-number-of-days-between-two-dates/
    static func calcDaysBetween(from: Date, to: Date) -> Int {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: from)
        let toDate = calendar.startOfDay(for: to)
        let numberOfDays = calendar.dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! + 1
    }
}
