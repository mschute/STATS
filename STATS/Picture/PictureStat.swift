import Foundation
import SwiftData

@Model
class PictureStat: Stat, Identifiable {
    var name: String
    var created: Date
    var desc: String
    var icon: String
    var reminder: Reminder?
    var category: Category?
    //If want this on CloudKit - this must be null rather than setting to empty array
    @Relationship(deleteRule: .cascade) var statEntry = [PictureEntry]()
    
    init(name: String = "", created: Date = Date(), desc: String = "", icon: String = "photo", reminder: Reminder? = nil, category: Category? = nil, statEntry: [PictureEntry] = []) {
        self.name = name
        self.created = created
        self.desc = desc
        self.icon = icon
        self.reminder = reminder
        self.category = category
        self.statEntry = statEntry
    }
}
