import Foundation
import SwiftData
import SwiftUI

@Model
class CounterStat: Stat, Identifiable {
    var name: String
    var created: Date
    @Relationship(deleteRule: .cascade) var statCounterEntry = [CounterEntry]()
    
    init(name: String, created: Date, statCounterEntry: [CounterEntry] = [CounterEntry]()) {
        self.name = name
        self.created = Date()
        self.statCounterEntry = statCounterEntry
    }
    
    //TODO: Design decision: Should the model have functions?
    //TODO: Need to write code for function
    func Delete(modelContext: ModelContext) {
        var temp = "temp code"
    }
    
    // https://www.hackingwithswift.com/quick-start/swiftdata/how-to-save-a-swiftdata-object#:~:text=At%20its%20simplest%20form%2C%20saving,save()%20on%20that%20context.
    func Remove(modelContext: ModelContext) {
        modelContext.delete(self)
        try? modelContext.save()
    }
    
    func detailView() -> AnyView {
        AnyView(CounterDetail(stat: self))
    }
}
