import Foundation

class AnyStat: Identifiable, Hashable {
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
    
    //https://www.hackingwithswift.com/forums/swift/form-picker-error-requires-that-x-conform-to-hashable/19961
    static func == (lhs: AnyStat, rhs: AnyStat) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
