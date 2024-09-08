import Foundation

//TODO: Can be changed to struct?
//TODO: Does this need Identifiable?
class AnyEntry: Identifiable {
    var entry: any Entry
    
    init(entry: any Entry) {
        self.entry = entry
    }
}

extension AnyEntry {
    static func getEntryDateRange(entryArray: [any Entry]) -> (startDate: Date, endDate: Date) {
        
        guard let firstEntry = entryArray.first else {
            return (DateUtility.startOfDay(date: Date()), DateUtility.endOfDay(date: Date()))
        }
        
        var startDate = firstEntry.timestamp
        var endDate = firstEntry.timestamp
        
        for entry in entryArray {
            if(startDate > entry.timestamp) {
                startDate = entry.timestamp
            } else if(endDate < entry.timestamp) {
                endDate = entry.timestamp
            }
        }
        
        return (DateUtility.startOfDay(date: startDate), DateUtility.endOfDay(date: endDate))
    }
}
