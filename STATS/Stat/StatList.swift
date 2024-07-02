//TODO: Need to extract List from the Main Page view - Need to decide what to do with this code
//import SwiftData
//import SwiftUI
//
//struct StatList: View {
//    @Environment(\.modelContext) var modelContext
//    private var stats: [AnyStat] = []
//    @Query var counters: [CounterStat] = []
//    @Query var decimals: [DecimalStat] = []
//    
//    init() {
//        decimals.forEach { stat in stats.append(AnyStat(stat: stat)) }
//        counters.forEach { stat in stats.append(AnyStat(stat: stat)) }
//    }
//    
//    var body: some View {
//        List {
//            ForEach(stats) { stat in
//                NavigationLink(value: stat) {
//                    LazyVStack(alignment: .leading) {
//                        Text(stat.name)
//                            .font(.headline)
//                    }
//                }
//            }
//            .onDelete(perform: deleteCounterStat)
//        }
//    }
//    
//    init(sort: SortDescriptor<StatsCounter>) {
//        _counter = Query(sort: [sort])
//    }
//    
//    init(sort: SortDescriptor<StatsCounter>) {
//        _counter = Query(filter: #Predicate {
//            $0.desc != ""
//        }, sort: [sort])
//    }
//    
//    init(sort: SortDescriptor<any StatisticType>, searchString: String) {
//        statsCounters = fetchCounterStats()
//        statsDecimals = fetchDecimalStats()
//        _allStats = Query(filter: #Predicate {
//            if searchString.isEmpty {
//                return true
//            } else {
//                return $0.title.localizedStandardContains(searchString)
//            }
//        }, sort: [sort])
//    }
//    
//    func deleteCounterStat(_ indexSet: IndexSet) {
//        for index in indexSet {
//            let counter = counter[index]
//            modelContext.delete(counter)
//        }
//    }
//    
//    func fetchCounterStats() -> [CounterStat] {
//        var countersArray: [CounterStat] = []
//        let fetchedCounters = FetchDescriptor<CounterStat>()
//        
//        do {
//            let results = try modelContext.fetch(fetchedCounters)
//            countersArray.append(contentsOf: results)
//        } catch {
//            print(error)
//        }
//        
//        return countersArray
//    }
//    
//    func fetchDecimalStats() -> [DecimalStat] {
//        var decimalArray: [DecimalStat] = []
//        let fetchedDecimal = FetchDescriptor<DecimalStat>()
//        
//        do {
//            let results = try modelContext.fetch(fetchedDecimal)
//            decimalArray.append(contentsOf: results)
//        } catch {
//            print(error)
//        }
//        
//        return decimalArray
//    }
//}

