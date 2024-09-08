import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query() private var counterStats: [CounterStat]
    @Query() private var decimalStats: [DecimalStat]
    @Query() private var pictureStats: [PictureStat]
    
    @State private var stats: [AnyStat] = []
    @State private var filter: String? = nil
    
    //https://www.avanderlee.com/swift/computed-property/
    private var filteredCounterStats: [CounterStat] {
        if let filter = filter {
            return counterStats.filter { $0.category?.name == filter }
        }
        return counterStats
    }
    
    private var filteredDecimalStats: [DecimalStat] {
        if let filter = filter {
            return decimalStats.filter { $0.category?.name == filter }
        }
        return decimalStats
    }
    
    private var filteredPictureStats: [PictureStat] {
        if let filter = filter {
            return pictureStats.filter { $0.category?.name == filter }
        }
        return pictureStats
    }
    
    var body: some View {
        VStack {
            // TODO: Refactor for one more view hierarhcy so the filter can be passed down and manual filtering is not needed.
            StatList(stats: $stats, filter: $filter)
                .task {
                    AnyStat.combineAllStats(stats: &stats, filteredCounterStats: filteredCounterStats, filteredDecimalStats: filteredDecimalStats, filteredPictureStats: filteredPictureStats)
                }
                .onChange(of: counterStats){
                    AnyStat.combineAllStats(stats: &stats, filteredCounterStats: filteredCounterStats, filteredDecimalStats: filteredDecimalStats, filteredPictureStats: filteredPictureStats)
                }
                .onChange(of: decimalStats){
                    AnyStat.combineAllStats(stats: &stats, filteredCounterStats: filteredCounterStats, filteredDecimalStats: filteredDecimalStats, filteredPictureStats: filteredPictureStats)
                }
                .onChange(of: pictureStats){
                    AnyStat.combineAllStats(stats: &stats, filteredCounterStats: filteredCounterStats, filteredDecimalStats: filteredDecimalStats, filteredPictureStats: filteredPictureStats)
                }
                .onChange(of: filter){
                    AnyStat.combineAllStats(stats: &stats, filteredCounterStats: filteredCounterStats, filteredDecimalStats: filteredDecimalStats, filteredPictureStats: filteredPictureStats)
                }
        }
    }
}
