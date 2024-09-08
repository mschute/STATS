import Foundation
import SwiftData
import SwiftUI

//TODO: Does this actually need to be Identifiable?
@Model
final class DecimalStat: Stat, Identifiable {
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
    var modelName: String {
        return "Decimal Stat"
    }
    
    var statColor: Color {
        return .mint
    }
    
    var gradientHighlight: Color {
        return .decimalHighlight
    }
}

extension DecimalStat {
    static func addDecimal(name: String, created: Date, desc: String, icon: String, unitName: String, trackAverage: Bool, trackTotal: Bool, hasReminder: Bool, interval: String, reminders: [Date], chosenCategory: Category?, modelContext: ModelContext) {
        let reminder = hasReminder ? Reminder(interval: Int(interval) ?? 1, reminderTime: reminders) : nil
        
        let newDecimalStat = DecimalStat(
            name: name,
            created: created,
            desc: desc,
            icon: icon,
            unitName: unitName,
            trackAverage: trackAverage,
            trackTotal: trackTotal,
            reminder: reminder,
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
            //Update existing reminder
            if let reminder = decimalStat.reminder {
                reminder.interval = Int(interval) ?? 1
                reminder.reminderTime = reminders
            } else {
                //Create and set new reminder if none previously
                decimalStat.reminder = Reminder(interval: Int(interval) ?? 1, reminderTime: reminders)
            }
        } else {
            //Remove reminder if it exists
            if let reminder = decimalStat.reminder {
                modelContext.delete(reminder)
                decimalStat.reminder = nil
            }
        }
        
        //Save() not necessary but included it for clarity in the purpose of the method
        do {
            try modelContext.save()
        } catch {
            print("Error saving decimal stat")
        }
    }
}
