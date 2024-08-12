import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(animation: .easeInOut) var counterStats: [CounterStat]
    @Query(animation: .easeInOut) var decimalStats: [DecimalStat]
    @Query(animation: .easeInOut) var pictureStats: [PictureStat]
    
    @State private var stats: [AnyStat] = []
    
    @State private var filter: String? = nil
    
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
    }
    
    //https://www.hackingwithswift.com/example-code/language/how-to-use-map-to-transform-an-array
    //https://www.tutorialspoint.com/how-do-i-concatenate-or-merge-arrays-in-swift
    private func combineStats() {
        stats = []
        
        stats += filteredCounterStats.map { AnyStat(stat: $0) }
        stats += filteredDecimalStats.map { AnyStat(stat: $0) }
        stats += filteredPictureStats.map { AnyStat(stat: $0) }
        
        sortStats()
    }
    
    private func sortStats() {
        stats.sort { $0.stat.created > $1.stat.created }
    }
}
