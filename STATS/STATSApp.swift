import SwiftData
import SwiftUI

@main
struct STATSApp: App {
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
    @StateObject private var selectedTab = NavbarTabs()
    @StateObject private var selectedDetailTab = StatTabs()
    @State private var showSplash = true
    
    //Does not need StatEntry models because the relationship is inferred
    public var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CounterStat.self, DecimalStat.self, PictureStat.self, Category.self, Reminder.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    //Splash Screen: https://www.youtube.com/watch?v=N7-QfGQrxlw
    var body: some Scene {
        WindowGroup {
            if (showSplash) {
                SplashView()
                    .transition(.opacity)
                    .animation(.easeInOut, value: 3)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                Navbar()
                    .environmentObject(selectedTab)
                    .environmentObject(selectedDetailTab)
                    .environment(\.font, Font.custom("Menlo", size: 17))
                    .accentColor(.universal)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
