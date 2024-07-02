import Foundation
import SwiftData
import SwiftUI

@Model
class CounterStat: Stat, Identifiable {
    var name: String
    var created: Date
    @Relationship(deleteRule: .cascade) var statEntry = [CounterEntry]()
    
    init(name: String, created: Date, statEntry: [CounterEntry] = [CounterEntry]()) {
        self.name = name
        self.created = Date()
        self.statEntry = statEntry
    }
    
//TODO: Design decision: Should the model have functions? Would be based on Stat Protocol
//https://www.hackingwithswift.com/quick-start/swiftdata/how-to-save-a-swiftdata-object#:~:text=At%20its%20simplest%20form%2C%20saving,save()%20on%20that%20context.

}
