import Foundation

class AnyStat: Identifiable {
    var stat: any Stat
    
    init(stat: any Stat) {
        self.stat = stat
    }
    
    static func getEntryDateRange(entryArray: [any Entry]) -> (startDate: Date, endDate: Date) {
        
        guard let firstEntry = entryArray.first else {
            return (Date(), Date())
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
        
        return (startDate, endDate)
    }
}
