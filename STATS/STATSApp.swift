import SwiftData
import SwiftUI


@main
struct STATSApp: App {
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
    @StateObject private var selectedTab = NavbarTabs()
    @StateObject private var selectedDetailTab = StatTabs()
    
    public var sharedModelContainer: ModelContainer = {
        //TODO: Need to add schema for Picture type
        let schema = Schema([
            DecimalStat.self, CounterStat.self, CounterEntry.self, DecimalEntry.self, Category.self, Reminder.self
            //DecimalStat.self, CounterStat.self, CounterEntry.self, DecimalEntry.self
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
                .environmentObject(selectedTab)
                .environmentObject(selectedDetailTab)
        }
        .modelContainer(sharedModelContainer)
    }
}
