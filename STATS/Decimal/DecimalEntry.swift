import Foundation
import SwiftData

@Model
class DecimalEntry: Entry, Identifiable {
    @Relationship var decimalStat: DecimalStat
    var entryId: UUID
    var timestamp: Date
    var value: Double
    
    init(decimalStat: DecimalStat, entryId: UUID, timestamp: Date, value: Double) {
        self.decimalStat = decimalStat
        self.entryId = entryId
        self.timestamp = timestamp
        self.value = value
    }
}
