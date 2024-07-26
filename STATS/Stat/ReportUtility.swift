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
    
//    static func calcTotalDays(startDate: Date, endDate: Date) -> Int {
//        let component = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
//        
//        if let daysDifference = component.day {
//            return daysDifference
//        } else {
//            return 0
//        }
//    }
    
    //TODO: If time, create count data by week and by month
    
    
}
