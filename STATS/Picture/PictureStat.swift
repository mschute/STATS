import Foundation
import SwiftData
import SwiftUI

@Model
class PictureStat: Stat, Identifiable {
    var name: String
    var created: Date
    var desc: String
    var icon: String
    var reminder: Reminder?
    var category: Category?
    
    @Relationship(deleteRule: .cascade) var statEntry = [PictureEntry]()
    
    init(name: String, created: Date, desc: String, icon: String, reminder: Reminder?, category: Category? = nil, statEntry: [PictureEntry] = [PictureEntry]()) {
        self.name = name
        self.desc = desc
        self.icon = icon
        self.created = created
        self.reminder = reminder
        self.category = category
        self.statEntry = statEntry
    }
}
