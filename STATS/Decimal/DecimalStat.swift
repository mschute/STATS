import Foundation
import SwiftData

@Model
class DecimalStat: Stat, Identifiable {
    var name: String
    var created: Date
    var desc: String
    var icon: String
    var unitName: String
    var trackAverage: Bool
    var trackTotal: Bool
    var reminder: Reminder?
    var category: Category?
    //If want this on CloudKit - this must be null rather than setting to empty array
    @Relationship(deleteRule: .cascade) var statEntry = [DecimalEntry]()
    
    init(name: String = "", created: Date = Date(), desc: String = "", icon: String = "number.circle.fill", unitName: String = "", trackAverage: Bool = false, trackTotal: Bool = false, reminder: Reminder? = nil, category: Category? = nil, statEntry: [DecimalEntry] = []) {
        self.name = name
        self.created = created
        self.desc = desc
        self.icon = icon
        self.unitName = unitName
        self.trackAverage = trackAverage
        self.trackTotal = trackTotal
        self.reminder = reminder
        self.category = category
        self.statEntry = statEntry
    }
}
