import Foundation

class AnyEntry: Identifiable {
    var entry: any Entry
    
    init(entry: any Entry) {
        self.entry = entry
    }
}

extension AnyEntry {
    static func getEntryDateRange(entryArray: [any Entry]) -> (startDate: Date, endDate: Date) {
        
        guard let firstEntry = entryArray.first else {
            return (DateUtility.startOfDay(for: Date()), DateUtility.endOfDay(for: Date()))
        }
        
        var startDate = firstEntry.timestamp
        var endDate = firstEntry.timestamp
        
        for entry in entryArray {
            if(startDate > entry.timestamp) {
                startDate = entry.timestamp
            } else if(endDate < entry.timestamp ) {
                endDate = entry.timestamp
            }
        }
        
        return (DateUtility.startOfDay(for: startDate), DateUtility.endOfDay(for: endDate))
    }
}
