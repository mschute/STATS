import SwiftData
import SwiftUI

struct StatList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Category.name) var categories: [Category]
    
    @Binding var stats: [AnyStat]
    @Binding var filter: String?
    
    @State private var isCreatedAscending = false
    @State private var isNameAscending = false
    
    @State private var newReminder: Date = Date()
    
    var body: some View {
        VStack {
            TopBar(title: "STAT LIST", topPadding: 0, bottomPadding: 20)
            List {
                ForEach(stats, id: \.self) { item in
                    StatUtility.Card(stat: item.stat)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    //Custom swipe action: https://useyourloaf.com/blog/swiftui-swipe-actions/#:~:text=The%20destructive%20button%20role%20gives,method.
                    //index of: https://medium.com/@wesleymatlock/advanced-techniques-for-using-list-in-swiftui-a03ee8e28f0e
                    // Swipe fully to delete: https://developer.apple.com/documentation/swiftui/view/swipeactions(edge:allowsfullswipe:content:)?changes=latest_major
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                if let index = stats.firstIndex(of: item) {
                                    deleteItems(offsets: IndexSet(integer: index))
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.cancel)
                        }
                }
            }
            .toolbar {
                ToolbarItem {
                    HStack {
                        Menu {
                            Button(action: { sortStats(sortType: .created) } ) {
                                Label("Sort by Date", systemImage: "calendar")
                            }
                            
                            Button(action: { sortStats(sortType: .name) } ) {
                                Label("Sort by Name", systemImage: "abc")
                            }
                        } label: {
                            Label("", systemImage: "arrow.up.arrow.down")
                        }
                        
                        
                        Menu {
                            ForEach(categories, id: \.id){ category in
                                if (filter == "\(category.name)") {
                                    Button("\(category.name)", systemImage: "checkmark", action: { filter = nil } )
                                } else {
                                    Button("\(category.name)", action: { filter = category.name } )
                                }
                            }
                        } label: {
                            Label("", systemImage: "line.3.horizontal.decrease.circle")
                        }
                    }
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            StatUtility.Remove(offsets: offsets, statItems: stats, modelContext: modelContext)
        }
    }
    
    private func sortStats(sortType: SortType) {
        
        switch sortType {
        case .created where isCreatedAscending == false:
            stats.sort { $0.stat.created < $1.stat.created}
            isCreatedAscending = true
        case .created:
            stats.sort { $0.stat.created > $1.stat.created }
            isCreatedAscending = false
        case .name where isNameAscending == false:
            stats.sort { $0.stat.name < $1.stat.name }
            isNameAscending = true
        case .name:
            stats.sort { $0.stat.name > $1.stat.name }
            isNameAscending = false
        }
    }
}
