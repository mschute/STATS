import Foundation
import SwiftData

@Model
class DecimalEntry: Entry, Identifiable {
    var entryId: UUID
    var timestamp: Date
    var value: Double
    var note: String
    //Associated relationship must be optional / does not need @Relationship
    var stat: DecimalStat?
    
    init(entryId: UUID, timestamp: Date, value: Double, note: String, stat: DecimalStat) {
        self.entryId = entryId
        self.timestamp = timestamp
        self.value = value
        self.note = note
        self.stat = stat
    }
}
