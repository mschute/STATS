import SwiftData
import SwiftUI
import Combine

@main
struct STATSApp: App {
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
    @StateObject private var selectedTab = NavbarTabs()
    @StateObject private var selectedDetailTab = StatTabs()
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true
    
    //Keyboard implementation: https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui#comment109419055_60010955
    @State private var keyboardIsShown = false
    @State private var keyboardHideMonitor: AnyCancellable? = nil
    @State private var keyboardShownMonitor: AnyCancellable? = nil
    
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
    //Dark mode: https://www.hackingwithswift.com/forums/swiftui/preferredcolorscheme-not-affecting-datepicker-and-confirmationdialog/11796
    var body: some Scene {
        WindowGroup {
            //Background color: https://stackoverflow.com/questions/56488228/xcode-11-swiftui-preview-dark-mode/58892521
            Navbar()
                .environmentObject(selectedTab)
                .environmentObject(selectedDetailTab)
                .environment(\.font, Font.custom("Menlo", size: 17))
                .tint(.main)
            // Needed to remove applyColorMode function to preferredColorScheme as was not loading correctly.
                .environment(\.keyboardIsShown, keyboardIsShown)
                .onDisappear { dismantleKeyboarMonitors() }
                .onAppear { setupKeyboardMonitors() }
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(sharedModelContainer)

    }
    
    func setupKeyboardMonitors() {
        keyboardShownMonitor = NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillShowNotification)
            .sink { _ in if !keyboardIsShown { keyboardIsShown = true } }
        
        keyboardHideMonitor = NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillHideNotification)
            .sink { _ in if keyboardIsShown { keyboardIsShown = false } }
    }
    
    func dismantleKeyboarMonitors() {
        keyboardHideMonitor?.cancel()
        keyboardShownMonitor?.cancel()
    }
}
