import Foundation
import SwiftData
import SwiftUI

class StatUtility {
    static func Remove(stat: Stat, modelContext: ModelContext) {
        if (stat is DecimalStat) {
            // as! https://stackoverflow.com/questions/28723625/how-to-convert-cast-from-a-protocol-to-a-class-in-swift
            modelContext.delete(stat as! DecimalStat)
        }
        
        if (stat is CounterStat){
            modelContext.delete(stat as! CounterStat)
        }
    }
    
    // TODO: Need to check out these functions
    
    static func Remove(index: Int, statItems: inout[AnyStat], modelContext: ModelContext){
        Remove(stat: statItems[index].stat, modelContext: modelContext)
        
        statItems.remove(at: index)
    }
    
    static func Remove(offsets: IndexSet, statItems: inout[AnyStat], modelContext: ModelContext) {
        for index in offsets {
            Remove(stat: statItems[index].stat, modelContext: modelContext)
        }
        
        statItems.remove(atOffsets: offsets)
    }
    
    static func fetchStats(modelContext: ModelContext) -> [AnyStat] {
        var stats: [AnyStat] = []
        let counters = FetchDescriptor<CounterStat>()
        let decimals = FetchDescriptor<DecimalStat>()
        
        stats.append(AnyStat(stat: counters as! Stat))
        stats.append(AnyStat(stat: decimals as! Stat))
    
        return stats
    }
    
    static func Card(stat: Stat) -> some View {
//        if (stat is DecimalStat) {
//            return AnyView(DecimalCard(stat: stat as! DecimalStat))
//        }
        
        if (stat is CounterStat) {
            return AnyView(CounterCard(stat: stat as! CounterStat))
        }
        
        return AnyView(Text("No item available"))
    }
}
