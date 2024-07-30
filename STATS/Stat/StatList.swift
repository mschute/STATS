import SwiftData
import SwiftUI

struct StatList: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @Binding var stats: [AnyStat]

    @Binding var filter: String?
    
    @State private var isCreatedAscending = false
    @State private var isNameAscending = false
    
    var body: some View {
        List {
            ForEach(stats) { item in
                StatUtility.Card(stat: item.stat)
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("Stat List")
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
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            StatUtility.Remove(offsets: offsets, statItems: stats, modelContext: modelContext)
        }
    }
    
    func sortStats(sortType: SortType) {
        
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
