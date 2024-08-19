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

extension PictureStat {
    static func addPicture(name: String, created: Date, desc: String, icon: String, interval: String, reminders: [Date], chosenCategory: Category?, modelContext: ModelContext) {
        let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
        let newPictureStat = PictureStat(
            name: name,
            created: created,
            desc: desc,
            icon: icon,
            reminder: newReminder,
            category: chosenCategory
        )
        
        modelContext.insert(newPictureStat)
    }
    
    static func updatePicture(pictureStat: PictureStat, name: String, created: Date, desc: String, icon: String, hasReminder: Bool, interval: String, reminders: [Date], chosenCategory: Category?, modelContext: ModelContext) {
        pictureStat.name = name
        pictureStat.created = created
        pictureStat.desc = desc
        pictureStat.icon = icon
        pictureStat.category = chosenCategory
        
        if hasReminder {
            if let reminder = pictureStat.reminder {
                reminder.interval = Int(interval) ?? 0
                reminder.reminderTime = reminders
            } else {
                let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
                pictureStat.reminder = newReminder
            }
        } else {
            if let reminder = pictureStat.reminder {
                modelContext.delete(reminder)
                pictureStat.reminder = nil
            }
        }

        do {
            try modelContext.save()
        } catch {
            print("Error saving picture stat")
        }
    }
}
