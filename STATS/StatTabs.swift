import Foundation

//https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
class StatTabs: ObservableObject {
    @Published var selectedDetailTab: DetailTab = .editStat
}
