import Foundation
import SwiftData

@Model
class CounterEntry: Entry, Identifiable {
    // Database migration failing, need to set to optional even though this is technically required.
    // Unsure why this needs to be optional but the one in the Decimal doesnt?
    //https://stackoverflow.com/questions/46092508/code-134110-validation-error-missing-attribute-values-on-mandatory-destination
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
