import SwiftData
import SwiftUI
import Combine

@main
struct STATSApp: App {
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
    @StateObject private var selectedTab = NavbarTabs()
    @StateObject private var selectedDetailTab = StatTabs()
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    //Tracks whether keyboard is currently shown
    @State private var keyboardIsShown: Bool = false
    @State private var keyboardHideMonitor: AnyCancellable? = nil
    @State private var keyboardShownMonitor: AnyCancellable? = nil
    
    //Does not need StatEntry models because the relationship is inferred
    public var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CounterStat.self, DecimalStat.self, PictureStat.self, Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    //Dark mode: https://www.hackingwithswift.com/forums/swiftui/preferredcolorscheme-not-affecting-datepicker-and-confirmationdialog/11796
    var body: some Scene {
        WindowGroup {
            //Background color: https://stackoverflow.com/questions/56488228/xcode-11-swiftui-preview-dark-mode/58892521
            Navbar()
                .environmentObject(selectedTab)
                .environmentObject(selectedDetailTab)
                .environment(\.keyboardIsShown, keyboardIsShown)
                .onDisappear { dismantleKeyboardMonitors() }
                .onAppear {
                    setupKeyboardMonitors()
                    UIApplication.shared.applyColorMode(isDarkMode: isDarkMode)
                    // Change alert tint color: https://www.hackingwithswift.com/forums/swiftui/alert-button-color-conforming-to-accentcolor/7193#:~:text=There%20is%20no%20way%20to,the%20system%20do%20its%20thing.
                    UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.dynamicMainColor(colorScheme: colorScheme)
                }
                .tint(.main)
                .environment(\.font, Font.custom("Menlo", size: 17))
        }
        .modelContainer(sharedModelContainer)
    }
    
    //Monitor the keyboard visibility and will update keyboardIsShown accordingly
    func setupKeyboardMonitors() {
        keyboardShownMonitor = NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillShowNotification)
            .sink { _ in if !keyboardIsShown { keyboardIsShown = true } }
        
        keyboardHideMonitor = NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillHideNotification)
            .sink { _ in if keyboardIsShown { keyboardIsShown = false } }
    }
    
    //Cancels subscription when no longer needeed
    func dismantleKeyboardMonitors() {
        keyboardHideMonitor?.cancel()
        keyboardShownMonitor?.cancel()
    }
}
