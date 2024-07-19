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
