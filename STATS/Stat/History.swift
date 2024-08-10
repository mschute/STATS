import SwiftData
import SwiftUI

// https://www.youtube.com/watch?v=Saw_sZWa4aQ
struct History: View {
    var stat: any Stat
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var dateRange: (startDate: Date, endDate: Date) = (Date(), Date())
    
    //https://stackoverflow.com/questions/77039981/swiftdata-query-with-predicate-on-relationship-model?ref=simplykyra.com
    //https://developer.apple.com/documentation/swiftdata/filtering-and-sorting-persistent-data
    init(stat: any Stat) {
        self.stat = stat
        _dateRange = State(initialValue: AnyStat.getEntryDateRange(entryArray: stat.statEntry))
        _startDate = State(initialValue: dateRange.startDate)
        _endDate = State(initialValue: dateRange.endDate)
    }

    var body: some View {
        VStack(spacing: 20) {
            Form {
                Section {
                    DateRangePicker(startDate: $startDate, endDate: $endDate)
                }
                StatUtility.EntryList(stat: stat, startDate: $startDate, endDate: $endDate)
            }
        }
        //Update date range to fix bug of entry not showing if timestamp is edited
        .onAppear {
            updateDateRange()
        }
    }
    
    private func updateDateRange() {
        dateRange = AnyStat.getEntryDateRange(entryArray: stat.statEntry)
        startDate = dateRange.startDate
        endDate = dateRange.endDate
    }
}

