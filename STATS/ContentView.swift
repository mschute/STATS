import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var decimals: [DecimalStat]
    @Query private var counters: [CounterStat]
    
    @State private var stats: [AnyStat] = []
    
    
    var body: some View {
        //TODO: Need the list extracted from the ContentView
        List {
            ForEach(stats) { item in
                StatUtility.Card(stat: item.stat)
            }
            .onDelete(perform: deleteItems)
            
        }
        .navigationTitle("Stat List")
        .task {
            fetchStats()
        }
        .toolbar {
            ToolbarItem{
                Menu {
                    //TODO: Implement sort
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
                //TODO: Implement filter?
            }
        }
    }
    
    //TODO: Where should delete function be held?
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            //TODO: Research this more
            StatUtility.Remove(offsets: offsets, statItems: &stats, modelContext: modelContext)
        }
    }
    
    //TODO: Can this be moved to StatUtility
    //https://www.hackingwithswift.com/example-code/language/how-to-use-map-to-transform-an-array
    //https://www.tutorialspoint.com/how-do-i-concatenate-or-merge-arrays-in-swift
    func fetchStats() {
        stats = []
        
        let fetchedCounters = FetchDescriptor<CounterStat>()
        let fetchedDecimals = FetchDescriptor<DecimalStat>()
        
        do {
            let counters = try modelContext.fetch(fetchedCounters)
            let decimals = try modelContext.fetch(fetchedDecimals)
            
            //Takes each stat and transforms it to an AnyStat object (with the decimal or counter stat assigned to the stat attribute) and appends it to the stats array
            stats += counters.map { AnyStat(stat: $0) }
            stats += decimals.map { AnyStat(stat: $0) }
            
        } catch {
            print("Add a stat!")
        }
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: CounterStat.self, DecimalStat.self, configurations: config)
//        
//        return ContentView()
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
