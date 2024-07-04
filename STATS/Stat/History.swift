import SwiftData
import SwiftUI

// https://www.youtube.com/watch?v=Saw_sZWa4aQ
struct History: View {
    @State var startDate: Date
    @State var endDate: Date
    
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
        
        DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            .datePickerStyle(.compact)
            .padding(.horizontal)
        
        DatePicker("End Date", selection: $endDate, displayedComponents: .date)
            .datePickerStyle(.compact)
            .padding()
        
        StatUtility.EntryList(stat: stat, startDate: $startDate, endDate: $endDate)
    }
}

