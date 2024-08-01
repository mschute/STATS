import Foundation
import SwiftData

@Model
class CounterEntry: Entry, Identifiable {
    var entryId: UUID
    var timestamp: Date
    var note: String
    //Associated relationship must be optional / does not need @Relationship https://www.youtube.com/watch?v=dAMFgq4tDPM
    //https://stackoverflow.com/questions/46092508/code-134110-validation-error-missing-attribute-values-on-mandatory-destination
    var stat: CounterStat?
    
    init(entryId: UUID = UUID(), timestamp: Date = Date(), note: String = "", stat: CounterStat? = nil) {
        self.entryId = entryId
        self.timestamp = timestamp
        self.note = note
        self.stat = stat
    }
}
