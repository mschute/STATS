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
    
    init(name: String, created: Date, desc: String, icon: String, unitName: String, trackAverage: Bool, trackTotal: Bool, reminder: Reminder?, category: Category?, statEntry: [DecimalEntry] = [DecimalEntry]()) {
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
