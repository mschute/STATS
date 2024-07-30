import Foundation
import SwiftData

@Model
class CounterEntry: Entry, Identifiable {
    //https://stackoverflow.com/questions/46092508/code-134110-validation-error-missing-attribute-values-on-mandatory-destination
    //Associated relationship must be optional / does not need @Relationship https://www.youtube.com/watch?v=dAMFgq4tDPM
    var counterStat: CounterStat?
    var entryId: UUID
    var timestamp: Date
    var note: String
    
    init(counterStat: CounterStat, entryId: UUID, timestamp: Date, note: String) {
        self.counterStat = counterStat
        self.entryId = entryId
        self.timestamp = timestamp
        self.note = note
    }
}
