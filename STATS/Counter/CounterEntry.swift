import Foundation
import SwiftData

@Model
class CounterEntry: Entry, Identifiable {
    @Relationship var counterStat: CounterStat
    var entryId: UUID
    var value: Int
    var timestamp: Date
    
    init(counterStat: CounterStat, entryId: UUID, value: Int, timestamp: Date) {
        self.counterStat = counterStat
        self.entryId = entryId
        self.value = value
        self.timestamp = timestamp
    }
}
