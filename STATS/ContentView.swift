import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var stats: [AnyStat] = []
    
    
    var body: some View {
        StatList(stats: $stats)
            .task {
                fetchStats()
            }
    }

    //https://www.hackingwithswift.com/example-code/language/how-to-use-map-to-transform-an-array
    //https://www.tutorialspoint.com/how-do-i-concatenate-or-merge-arrays-in-swift
    func fetchStats() {
        stats = []
        
        let fetchedCounters = FetchDescriptor<CounterStat>()
        let fetchedDecimals = FetchDescriptor<DecimalStat>()
        
        do {
            let counters = try modelContext.fetch(fetchedCounters)
            let decimals = try modelContext.fetch(fetchedDecimals)
            print(modelContext.sqliteCommand)
            
            //Takes each stat and transforms it to an AnyStat object (with the decimal or counter stat assigned to the stat attribute) and appends it to the stats array
            stats += counters.map { AnyStat(stat: $0) }
            stats += decimals.map { AnyStat(stat: $0) }
            
            sortStats()
            
        } catch {
            print("Add a stat!")
        }
    }
    
    func sortStats(){
        stats.sort { $0.stat.created > $1.stat.created}
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
