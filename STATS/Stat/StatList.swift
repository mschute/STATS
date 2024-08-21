import SwiftData
import SwiftUI

struct StatList: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
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
                if stats.isEmpty {
                    Text("No current stats")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(stats, id: \.self) { item in
                        AnyStat.Card(stat: item.stat)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        //Custom swipe action: https://useyourloaf.com/blog/swiftui-swipe-actions/#:~:text=The%20destructive%20button%20role%20gives,method.
                        //index of: https://medium.com/@wesleymatlock/advanced-techniques-for-using-list-in-swiftui-a03ee8e28f0e
                        // Swipe fully to delete: https://developer.apple.com/documentation/swiftui/view/swipeactions(edge:allowsfullswipe:content:)?changes=latest_major
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    if let index = stats.firstIndex(of: item) {
                                        AnyStat.deleteItems(offsets: IndexSet(integer: index), stats: stats, modelContext: modelContext)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.cancel)
                            }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem {
                    HStack {
                        Menu {
                            Button(action: { AnyStat.sortStats(sortType: .created, stats: &stats, isCreatedAscending: &isCreatedAscending, isNameAscending: &isNameAscending)
                                Haptics.shared.play(.light)
                            } ) {
                                Label("Sort by Date", systemImage: "calendar")
                            }
                            
                            Button(action: { AnyStat.sortStats(sortType: .name, stats: &stats, isCreatedAscending: &isCreatedAscending, isNameAscending: &isNameAscending)
                                Haptics.shared.play(.light)
                            } ) {
                                Label("Sort by Name", systemImage: "abc")
                            }
                        } label: {
                            Label("", systemImage: "arrow.up.arrow.down")
                        }
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    Haptics.shared.play(.light)
                                }
                        )
                        
                        Menu {
                            ForEach(categories, id: \.id){ category in
                                if (filter == "\(category.name)") {
                                    Button("\(category.name)", systemImage: "checkmark", action: {
                                        filter = nil
                                        Haptics.shared.play(.light)
                                    } )
                                } else {
                                    Button("\(category.name)", action: {
                                        filter = category.name
                                        Haptics.shared.play(.light)
                                    } )
                                }
                            }
                        } label: {
                            Label("", systemImage: "line.3.horizontal.decrease.circle")
                        }
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    Haptics.shared.play(.light)
                                }
                        )
                    }
                }
            }
        }
    }
}
