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
    @Relationship(deleteRule: .cascade) var reminder: Reminder?
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

extension DecimalStat {
    static func addDecimal(name: String, created: Date, desc: String, icon: String, unitName: String, trackAverage: Bool, trackTotal: Bool, interval: String, reminders: [Date], chosenCategory: Category?, modelContext: ModelContext) {
        let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
        let newDecimalStat = DecimalStat(
            name: name,
            created: created,
            desc: desc,
            icon: icon,
            unitName: unitName,
            trackAverage: trackAverage,
            trackTotal: trackTotal,
            reminder: newReminder,
            category: chosenCategory
        )
        
        modelContext.insert(newDecimalStat)
    }
    
    static func updateDecimal(decimalStat: DecimalStat, name: String, created: Date, desc: String, icon: String, unitName: String, trackAverage: Bool, trackTotal: Bool, hasReminder: Bool, interval: String, reminders: [Date], chosenCategory: Category?, modelContext: ModelContext) {
        decimalStat.name = name
        decimalStat.created = created
        decimalStat.desc = desc
        decimalStat.unitName = unitName
        decimalStat.trackAverage = trackAverage
        decimalStat.trackTotal = trackTotal
        decimalStat.icon = icon
        decimalStat.category = chosenCategory
        
        if hasReminder {
            if let reminder = decimalStat.reminder {
                reminder.interval = Int(interval) ?? 0
                reminder.reminderTime = reminders
            } else {
                let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
                decimalStat.reminder = newReminder
            }
        } else {
            if let reminder = decimalStat.reminder {
                modelContext.delete(reminder)
                decimalStat.reminder = nil
            }
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving decimal stat")
        }
    }
}
