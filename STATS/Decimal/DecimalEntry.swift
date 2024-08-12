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
    
    init(entryId: UUID = UUID(), timestamp: Date = Date(), value: Double = 0.0, note: String = "") {
        self.entryId = entryId
        self.timestamp = timestamp
        self.value = value
        self.note = note
    }
}
