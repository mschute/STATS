import Foundation
import SwiftData

@Model
class Reminder {
    var interval: Int
    var reminderTime: [Date]
    
    init(interval: Int, reminderTime: [Date]) {
        self.interval = interval
        self.reminderTime = reminderTime
    }
}

extension Reminder {
    static func addReminder(reminders: inout [Date], newReminder: inout Date) {
        reminders.append(newReminder)
        sortReminders(reminders: &reminders)
    }
    
    //TODO: Could the reminderTime be deleted off the modelContext?
    //TODO: Is there a way to sort these without using inout? Is it just using @Query for reminder plus predicate? Then that needs to be a nested view hierarchy
    static func deleteReminder(offsets: IndexSet, reminders: inout [Date]) {
        reminders.remove(atOffsets: offsets)
        sortReminders(reminders: &reminders)
    }
    
    static func sortReminders(reminders: inout [Date]) {
        reminders.sort(by: { $0 < $1 } )
    }
}
