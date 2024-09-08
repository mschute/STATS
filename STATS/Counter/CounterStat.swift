import Foundation
import SwiftData
import SwiftUI

//TODO: Does this actually need to be identifiable?
@Model
final class CounterStat: Stat, Identifiable {
    var name: String
    var created: Date
    var desc: String
    var icon: String
    @Relationship(deleteRule: .cascade) var reminder: Reminder?
    var category: Category?
    static var modelName: String = "Counter Stat"
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
    var modelName: String {
        return "Counter Stat"
    }
    
    var statColor: Color {
        return .teal
    }
    
    var gradientHighlight: Color {
        return .counterHighlight
    }
}

extension CounterStat {
    static func addCounter(hasReminder: Bool, interval: String, reminders: [Date], name: String, created: Date, desc: String, icon: String, chosenCategory: Category?, modelContext: ModelContext) {
        let reminder = hasReminder ? Reminder(interval: Int(interval) ?? 1, reminderTime: reminders) : nil

        let newCounterStat = CounterStat(
            name: name,
            created: created,
            desc: desc,
            icon: icon,
            reminder: reminder,
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
            //Update existing reminder
            if let reminder = counterStat.reminder {
                reminder.interval = Int(interval) ?? 1
                reminder.reminderTime = reminders
            } else {
                //Create and set new reminder if none previously
                counterStat.reminder = Reminder(interval: Int(interval) ?? 1, reminderTime: reminders)
            }
        } else {
            //Remove reminder if it exists
            if let reminder = counterStat.reminder {
                modelContext.delete(reminder)
                counterStat.reminder = nil
            }
        }
        
        //Save() not necessary but included it for clarity in the purpose of the method
        do {
            try modelContext.save()
        } catch {
            print("Error saving counter stat")
        }
    }
}
