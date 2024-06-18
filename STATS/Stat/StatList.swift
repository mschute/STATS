//
//  StatListingView.swift
//  STATS
//
//  Created by Staff on 12/06/2024.
//

import SwiftData
import SwiftUI

struct StatList: View {
    @Environment(\.modelContext) var modelContext
    private var allStats: [any StatisticType] = []
    private var statsCounters: [StatsCounter] = []
    private var statsDecimals: [StatsDecimal] = []
    //Need to fetch Counters and Decimals and then append it to stat type
    @Query var counter: [StatsCounter]
    @Query var decimal: [StatsDecimal]
    //@Query(sort: \StatsCounter.title, order: .reverse) var counter: [StatsCounter]
    //private var counter: [StatsCounter]
    
    var body: some View {
        List {
            ForEach(allStats, id: \.statId) { stat in
                NavigationLink(value: stat) {
                    LazyVStack(alignment: .leading) {
                        Text(stat.title)
                            .font(.headline)
                        Text(stat.desc)
                            .font(.caption)
                    }
                }
            }
            .onDelete(perform: deleteCounterStat)
        }
    }
    
//    init(sort: SortDescriptor<StatsCounter>) {
//        _counter = Query(sort: [sort])
//        
//    }
    
//    init(sort: SortDescriptor<StatsCounter>) {
//        _counter = Query(filter: #Predicate {
//            $0.desc != ""
//        }, sort: [sort])
//    }
    
//    init(sort: SortDescriptor<any StatisticType>, searchString: String) {
//        //statsCounters = fetchCounterStats()
//        //statsDecimals = fetchDecimalStats()
//        _allStats = Query(filter: #Predicate {
//            if searchString.isEmpty {
//                return true
//            } else {
//                return $0.title.localizedStandardContains(searchString)
//            }
//        }, sort: [sort])
//    }
    
    func deleteCounterStat(_ indexSet: IndexSet) {
        for index in indexSet {
            let counter = counter[index]
            modelContext.delete(counter)
        }
    }
    
    func fetchCounterStats() -> [StatsCounter] {
        var countersArray: [StatsCounter] = []
        let fetchedCounters = FetchDescriptor<StatsCounter>()
        
        do {
            let results = try modelContext.fetch(fetchedCounters)
            countersArray.append(contentsOf: results)
        } catch {
            print(error)
        }
        
        return countersArray
    }
    
    func fetchDecimalStats() -> [StatsDecimal] {
        var decimalArray: [StatsDecimal] = []
        let fetchedDecimal = FetchDescriptor<StatsDecimal>()
        
        do {
            let results = try modelContext.fetch(fetchedDecimal)
            decimalArray.append(contentsOf: results)
        } catch {
            print(error)
        }
        
        return decimalArray
    }
}

//struct AnyStat: StatisticType {
//    
//    private var _stat: any StatisticType
//    
//    init(_stat: any StatisticType) {
//        self._stat = _stat
//    }
//}

//#Preview {
//    StatListingView()
//}

