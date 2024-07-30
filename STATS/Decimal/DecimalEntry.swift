import Foundation
import SwiftData

@Model
class DecimalEntry: Entry, Identifiable {
    var decimalStat: DecimalStat?
    var entryId: UUID
    var timestamp: Date
    var value: Double
    var note: String
    
    init(decimalStat: DecimalStat, entryId: UUID, timestamp: Date, value: Double, note: String) {
        self.decimalStat = decimalStat
        self.entryId = entryId
        self.timestamp = timestamp
        self.value = value
        self.note = note
    }
}
