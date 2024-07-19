import SwiftData
import SwiftUI

// https://www.youtube.com/watch?v=Saw_sZWa4aQ
struct History: View {
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    private var stat: any Stat
    
    //https://stackoverflow.com/questions/77039981/swiftdata-query-with-predicate-on-relationship-model?ref=simplykyra.com
    //https://developer.apple.com/documentation/swiftdata/filtering-and-sorting-persistent-data
    init(stat: any Stat) {
        self.stat = stat
        
        let dateRange = AnyStat.getEntryDateRange(entryArray: stat.statEntry)
        _startDate = State(initialValue: dateRange.startDate)
        _endDate = State(initialValue: dateRange.endDate)
    }

    var body: some View {
        Text("History")
            .font(.largeTitle)
        
        DateRangePicker(startDate: $startDate, endDate: $endDate)
        
        StatUtility.EntryList(stat: stat, startDate: $startDate, endDate: $endDate)
    }
}

