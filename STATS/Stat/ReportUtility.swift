import Foundation

class ReportUtility {
    
    //TODO: Should I create ViewModels for the Reports instead?
    
    //Common amongs all report
    static func calcTotalEntriesDateRange(stat: any Stat, startDate: Date, endDate: Date) -> String {
        if(stat.statEntry.isEmpty) {
            return "No current entries"
        }
        var count = 0
        
        for entry in stat.statEntry {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                count += 1
            }
        }
        return String(count)
    }
    
    //Common amongst all report
    static func calcTotalEntries(stat: any Stat) -> String {
        if(stat.statEntry.isEmpty) {
            return "No current entries"
        }
        var count = 0
        
        for _ in stat.statEntry {
                count += 1
        }
        return String(count)
    }
    
    //Count specific?
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
    
    //Common amongst all reports?
    static func calcTotalDays(startDate: Date, endDate: Date) -> Int {
        let component = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        
        if let daysDifference = component.day {
            return daysDifference
        } else {
            return 0
        }
    }
    
    //Specific to count?
    static func createDayCountData(statEntries: [any Entry], startDate: Date, endDate: Date) -> [CountDayData] {
        var dateCounts: [Date : Int] = [:]
        let calendar = Calendar.current
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                //https://developer.apple.com/documentation/foundation/calendar/2293783-startofday
                let date = calendar.startOfDay(for: entry.timestamp)
                dateCounts[date, default: 0] += 1
            }
        }
        
        return dateCounts.map{ CountDayData(day: $0.key, count: $0.value) }
    }
    
    //TODO: If time, create count data by week and by month
    
    //Specific to decimal
    static func calcSmallestValueAllTime (statEntries: [DecimalEntry]) -> String {
        if(statEntries.isEmpty) {
            return "No current entries"
        }
        
        var smallestValue = statEntries[0].value
        
        for entry in statEntries {
            if (entry.value < smallestValue) {
                smallestValue = entry.value
            }
        }
        return String(smallestValue)
    }
    
    //Specific to decimal
    static func calcLargestValueAllTime (statEntries: [DecimalEntry]) -> String {
        if(statEntries.isEmpty) {
            return "No current entries"
        }
        
        var largestValue = statEntries[0].value
        
        for entry in statEntries {
            if (entry.value > largestValue) {
                largestValue = entry.value
            }
        }
        return String(largestValue)
    }
    
    //Specific to decimal
    static func calcSmallestValueDateRange (statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> String {
        if(statEntries.isEmpty) {
            return "No current entries"
        }
        
        var smallestValue = statEntries[0].value
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                if (entry.value < smallestValue) {
                    smallestValue = entry.value
                }
            }
        }
        return String(smallestValue)
    }
    
    //Specific to decimal
    static func calcLargestValueDateRange (statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> String {
        if(statEntries.isEmpty) {
            return "No current entries"
        }
        
        var largestValue = statEntries[0].value
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                if (entry.value > largestValue) {
                    largestValue = entry.value
                }
            }
        }
        return String(largestValue)
    }
    
    //Specific to decimal
    static func calcTotalValue (statEntries: [DecimalEntry]) -> String {
        if(statEntries.isEmpty) {
            return "No current entries"
        }
        
        var sumValue = 0.0
        
        for entry in statEntries {
            sumValue += entry.value
        }
        return String(sumValue)
    }
    
    //Specific to decimal
    static func calcTotalValueDateRange (statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> String {
        if(statEntries.isEmpty) {
            return "No current entries"
        }
        
        var sumValue = 0.0
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                sumValue += entry.value
            }
        }
        return String(sumValue)
    }
    
    //Specific to decimal
    static func calcAvgValue (statEntries: [DecimalEntry]) -> String {
        if(statEntries.isEmpty) {
            return "No current entries"
        }
        
        var sumValue = 0.0
        var count = 0.0
        
        for entry in statEntries {
            sumValue += entry.value
            count += 1
        }
        return String(sumValue / count)
    }
    
    //Specific to decimal
    static func calcAvgValueDateRange (statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> String {
        if(statEntries.isEmpty) {
            return "No current entries"
        }
        
        var sumValue = 0.0
        var count = 0.0
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                sumValue += entry.value
                count += 1
            }
        }
        return String(sumValue / count)
    }
    
    //Specific to decimal?
    static func createDayValueData(statEntries: [DecimalEntry], startDate: Date, endDate: Date) -> [ValueDayData] {
        var dateValues: [Date : Double] = [:]
        let calendar = Calendar.current
        
        for entry in statEntries {
            if (entry.timestamp >= startDate && entry.timestamp <= endDate) {
                //https://developer.apple.com/documentation/foundation/calendar/2293783-startofday
                let date = calendar.startOfDay(for: entry.timestamp)
                dateValues[date, default: 0] += entry.value
            }
        }
        
        let data = dateValues.map{ ValueDayData(day: $0.key, value: $0.value) }
        //Sorting https://stackoverflow.com/questions/25377177/sort-dictionary-by-keys
        return data.sorted(by: { $0.day < $1.day })
    }
}
