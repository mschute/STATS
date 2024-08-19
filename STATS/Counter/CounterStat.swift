import Foundation
import SwiftData

@Model
class CounterStat: Stat, Identifiable {
    var name: String
    var created: Date
    var desc: String
    var icon: String
    var reminder: Reminder?
    var category: Category?
    //If want this on CloudKit - this must be null rather than setting to empty array
    @Relationship(deleteRule: .cascade) var statEntry = [CounterEntry]()
    
    init(name: String = "", created: Date = Date(), desc: String = "", icon: String = "goforward", reminder: Reminder? = nil, category: Category? = nil, statEntry: [CounterEntry] = []) {
        self.name = name
        self.created = created
        self.desc = desc
        self.icon = icon
        self.reminder = reminder
        self.category = category
        self.statEntry = statEntry
    }
}

extension CounterStat {
    static func addCounter(interval: String, reminders: [Date], name: String, created: Date, desc: String, icon: String, chosenCategory: Category?, modelContext: ModelContext) {
        let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
        let newCounterStat = CounterStat(
            name: name,
            created: created,
            desc: desc,
            icon: icon,
            reminder: newReminder,
            category: chosenCategory
        )

        modelContext.insert(newCounterStat)
    }
    
    static func updateCounter(counterStat: CounterStat, name: String, created: Date, desc: String, icon: String, chosenCategory: Category?, hasReminder: Bool, interval: String, reminders: [Date], modelContext: ModelContext) {
        counterStat.name = name
        counterStat.created = created
        counterStat.desc = desc
        counterStat.icon = icon
        counterStat.category = chosenCategory
        
        if hasReminder {
            if let reminder = counterStat.reminder {
                reminder.interval = Int(interval) ?? 0
                reminder.reminderTime = reminders
            } else {
                let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
                counterStat.reminder = newReminder
            }
        } else {
            if let reminder = counterStat.reminder {
                modelContext.delete(reminder)
                counterStat.reminder = nil
            }
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving counter stat")
        }
    }
}
