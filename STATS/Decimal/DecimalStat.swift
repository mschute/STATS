import Foundation
import SwiftData
import SwiftUI

@Model
class DecimalStat: Stat, Identifiable {
    var name: String
    var created: Date
    var desc: String
    var icon: String
    var unitName: String
    var reminder: Reminder?
    var trackAverage: Bool
    var trackTotal: Bool
    var category: Category?

    @Relationship(deleteRule: .cascade) var statEntry = [DecimalEntry]()
    
    init(name: String, created: Date, desc: String, icon: String, unitName: String, reminder: Reminder?, trackAverage: Bool, trackTotal: Bool, category: Category?, statEntry: [DecimalEntry] = [DecimalEntry]()) {
        self.name = name
        self.created = created
        self.desc = desc
        self.icon = icon
        self.unitName = unitName
        self.reminder = reminder
        self.trackAverage = trackAverage
        self.trackTotal = trackTotal
        self.category = category
        self.statEntry = statEntry
    }
}
