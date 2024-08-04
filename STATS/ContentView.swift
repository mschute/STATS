import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(animation: .easeInOut) var counterStats: [CounterStat]
    @Query(animation: .easeInOut) var decimalStats: [DecimalStat]
    @Query(animation: .easeInOut) var pictureStats: [PictureStat]
    
    @State private var stats: [AnyStat] = []
    
    @State var filter: String? = nil
    
    //https://www.avanderlee.com/swift/computed-property/
    var filteredCounterStats: [CounterStat] {
        if let filter = filter {
            return counterStats.filter { $0.category?.name == filter }
        }
        return counterStats
    }
    
    var filteredDecimalStats: [DecimalStat] {
        if let filter = filter {
            return decimalStats.filter { $0.category?.name == filter }
        }
        return decimalStats
    }
    
    var filteredPictureStats: [PictureStat] {
        if let filter = filter {
            return pictureStats.filter { $0.category?.name == filter }
        }
        return pictureStats
    }
    
    var body: some View {
        VStack {
            StatList(stats: $stats, filter: $filter)
                .task {
                    combineStats()
                }
                .onChange(of: counterStats){
                    combineStats()
                }
                .onChange(of: decimalStats){
                    combineStats()
                }
                .onChange(of: pictureStats){
                    combineStats()
                }
                .onChange(of: filter){
                    combineStats()
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    //https://www.hackingwithswift.com/example-code/language/how-to-use-map-to-transform-an-array
    //https://www.tutorialspoint.com/how-do-i-concatenate-or-merge-arrays-in-swift
    func combineStats() {
        stats = []
        
        stats += filteredCounterStats.map { AnyStat(stat: $0) }
        stats += filteredDecimalStats.map { AnyStat(stat: $0) }
        stats += filteredPictureStats.map { AnyStat(stat: $0) }
        
        sortStats()
    }
    
    func sortStats() {
        stats.sort { $0.stat.created > $1.stat.created }
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
