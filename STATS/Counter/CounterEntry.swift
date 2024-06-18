import Foundation
import SwiftData

@Model

//TODO: does this need to conform to Identifiable?
//TODO: Should I set this to have a relationship with DecimalStat?
class CounterEntry: Identifiable {
    var value: Int
    var counterEntryID: UUID
    var timestamp: Date
    
    init(value: Int, counterEntryID: UUID, timestamp: Date) {
        self.value = value
        self.counterEntryID = counterEntryID
        self.timestamp = timestamp
    }
}
