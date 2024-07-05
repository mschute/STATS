import Foundation

//https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
class NavbarTabs: ObservableObject {
    @Published var selectedTab: Tab = .statList
}
