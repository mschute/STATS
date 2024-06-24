import SwiftData
import SwiftUI


@main
struct STATSApp: App {
    public var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            DecimalStat.self, CounterStat.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            Navbar()
        }
        .modelContainer(sharedModelContainer)
    }
}
