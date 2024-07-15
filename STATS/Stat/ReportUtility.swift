import Foundation

class ReportUtility {
    
    static func calcTimePeriodTotal(stat: any Stat, startDate: Date, endDate: Date) -> String {
        var count = 0
        
        for entry in stat.statEntry {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                count += 1
            }
        }
        return String(count)
    }
    
    static func calcTimeOfDay(stat: any Stat) -> (timeOfDay: TimeOfDay, count: String) {
        var timeOfDayCounts: [TimeOfDay: Int] = [
            .morning: 0,
            .afternoon: 0,
            .evening: 0,
            .overnight: 0
        ]
        
        let calendar = Calendar.current
        
        for entry in stat.statEntry {
            let hour = calendar.component(.hour, from: entry.timestamp)
            
            switch hour {
            case 6..<12:
                //https://www.hackingwithswift.com/sixty/2/6/dictionary-default-values
                timeOfDayCounts[.morning, default: 0] += 1
            case 12..<18:
                timeOfDayCounts[.afternoon, default: 0] += 1
            case 18..<24:
                timeOfDayCounts[.evening, default: 0] += 1
            default:
                timeOfDayCounts[.overnight, default: 0] += 1
            }
        }
        
        if let maxPeriod = timeOfDayCounts.max(by: { $0.value < $1.value } ) {
            return (timeOfDay: maxPeriod.key, count: String(maxPeriod.value))
        } else {
            //Structural binding
            return (timeOfDay: .morning, count: String(0))
        }
    }
    
    static func calcTotalDays(startDate: Date, endDate: Date) -> Int {
        let component = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        
        if let daysDifference = component.day {
            return daysDifference
        } else {
            return 0
        }
    }
    
    static func createDayCountData(statEntries: [any Entry], startDate: Date, endDate: Date) -> [CountDayData] {
        var dateCounts: [Date : Int] = [:]
        let calendar = Calendar.current
        
        for entry in statEntries {
            if entry.timestamp >= startDate && entry.timestamp <= endDate {
                //https://developer.apple.com/documentation/foundation/calendar/2293783-startofday
                let date = calendar.startOfDay(for: entry.timestamp)
                dateCounts[date, default: 0] += 1
            }
        }
        
        return dateCounts.map{ CountDayData(day: $0.key, count: $0.value) }
    }
}
