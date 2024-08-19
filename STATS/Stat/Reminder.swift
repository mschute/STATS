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
    
    static func deleteReminder(at offsets: IndexSet, reminders: inout [Date]) {
        reminders.remove(atOffsets: offsets)
        sortReminders(reminders: &reminders)
    }
    
    static func sortReminders(reminders: inout [Date]) {
        reminders.sort(by: { $0 < $1 } )
    }
}
