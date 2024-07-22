import Foundation
import SwiftData
import SwiftUI

@Model
class CounterStat: Stat, Identifiable {
    var name: String
    var created: Date
    var desc: String
    var icon: String
    var reminder: Reminder?
    var category: Category?
    
    //If want this on CloudKit - this must be null rather than setting to empty array
    @Relationship(deleteRule: .cascade, inverse: \CounterEntry.counterStat) var statEntry = [CounterEntry]()
    
    init(name: String, desc: String, icon: String, created: Date, reminder: Reminder?, category: Category? = nil, statEntry: [CounterEntry] = [CounterEntry]()) {
        self.name = name
        self.desc = desc
        self.icon = icon
        self.created = created
        self.reminder = reminder
        self.category = category
        self.statEntry = statEntry
    }
    
//TODO: Design decision: Should the model have functions? Would be based on Stat Protocol
//https://www.hackingwithswift.com/quick-start/swiftdata/how-to-save-a-swiftdata-object#:~:text=At%20its%20simplest%20form%2C%20saving,save()%20on%20that%20context.

}
