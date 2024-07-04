import SwiftData
import SwiftUI

struct StatList: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var stats: [AnyStat]
    
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
            ToolbarItem{
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
                //TODO: Implement filter? After adding tag to Model properties
            }
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            // '&' means its passed by reference
            StatUtility.Remove(offsets: offsets, statItems: &stats, modelContext: modelContext)
        }
    }
    
    func sortStats(sortType: SortType){
        
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
