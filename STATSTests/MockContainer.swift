import Foundation
import SwiftData

@MainActor
public var mockContainer: ModelContainer {
    do {
        let schema = Schema([
            CounterStat.self,
            CounterEntry.self,
            Category.self,
            Reminder.self
        ])
        let container = try ModelContainer(for: schema, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        return container
    } catch {
        fatalError("Failed to create container.")
    }
}
