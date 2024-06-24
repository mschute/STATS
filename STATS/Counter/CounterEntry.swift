import Foundation
import SwiftData

@Model

//TODO: Should I set this to have a relationship with CounterStat?
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
