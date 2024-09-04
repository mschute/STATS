import SwiftData
import SwiftUI

// https://www.youtube.com/watch?v=Saw_sZWa4aQ
struct History: View {
    var stat: any Stat
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var dateRange: (startDate: Date, endDate: Date)
    
    init(stat: any Stat) {
        self.stat = stat
        // dateRange is changed to let, then startDate and endDate will need a value set in the attribute list
        var dateRange = AnyEntry.getEntryDateRange(entryArray: stat.statEntry)
        _dateRange = State(initialValue: dateRange)
        _startDate = State(initialValue: dateRange.startDate)
        _endDate = State(initialValue: dateRange.endDate)
    }

    var body: some View {
        VStack(spacing: 20) {
            Form {
                Section {
                    DateRangePicker(startDate: $startDate, endDate: $endDate)
                }
                AnyStat.EntryList(stat: stat, startDate: $startDate, endDate: $endDate)
            }
        }
        //Update date range to fix bug of entry not showing if timestamp is edited
        .onAppear {
            AnyStat.updateDateRange(stat: stat, dateRange: &dateRange, startDate: &startDate, endDate: &endDate)
        }
    }
}
