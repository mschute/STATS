import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var decimals: [DecimalStat]
    @Query private var counters: [CounterStat]
    
    @State private var stats: [AnyStat] = []
    
    
    var body: some View {
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
                    //TODO: Need to implement sort
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
                //TODO: Implement filter?
            }
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            //TODO: Research this more
            StatUtility.Remove(offsets: offsets, statItems: &stats, modelContext: modelContext)
        }
    }
    
    //TODO: Need to move this to Decimal Form
    func addDecimal() {
        return
        //        let decimal = DecimalStat(name: name, date: date, unitName: unitName)
        //        modelContext.insert(decimal)
        //        path.append(decimal)
    }
    
    //TODO: Can this be moved to StatUtility
    //TODO: Is there another solution other than .map? Need reference
    func fetchStats() {
        stats = []
        
        let fetchedCounters = FetchDescriptor<CounterStat>()
        let fetchedDecimals = FetchDescriptor<DecimalStat>()
        
        do{
            let counters = try modelContext.fetch(fetchedCounters)
            let decimals = try modelContext.fetch(fetchedDecimals)
            
            stats += counters.map { AnyStat(stat: $0) }
            stats += decimals.map { AnyStat(stat: $0) }
            
        } catch {
            print("Add a stat!")
        }
    }
}

//TODO: Do I dare fix this preview?
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CounterStat.self, DecimalStat.self, configurations: config)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
