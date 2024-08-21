import Foundation
import SwiftData

@Model
class PictureStat: Stat, Identifiable {
    var name: String
    var created: Date
    var desc: String
    var icon: String
    @Relationship(deleteRule: .cascade) var reminder: Reminder?
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
    static func addPicture(name: String, created: Date, desc: String, icon: String, hasReminder: Bool, interval: String, reminders: [Date], chosenCategory: Category?, modelContext: ModelContext) {
        let reminder = hasReminder ? Reminder(interval: Int(interval) ?? 1, reminderTime: reminders) : nil
        
        let newPictureStat = PictureStat(
            name: name,
            created: created,
            desc: desc,
            icon: icon,
            reminder: reminder,
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
            //Update existing reminder
            if let reminder = pictureStat.reminder {
                reminder.interval = Int(interval) ?? 1
                reminder.reminderTime = reminders
            } else {
                //Create and set new reminder if none previously
                pictureStat.reminder = Reminder(interval: Int(interval) ?? 1, reminderTime: reminders)
            }
        } else {
            //Remove reminder if it exists
            if let reminder = pictureStat.reminder {
                modelContext.delete(reminder)
                pictureStat.reminder = nil
            }
        }

        //Save() not necessary but included it for clarity in the purpose of the method
        do {
            try modelContext.save()
        } catch {
            print("Error saving picture stat")
        }
    }
}
