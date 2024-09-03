import SwiftData
import SwiftUI

struct Report: View {
    var stat: any Stat
    
    @State private var startDate: Date
    @State private var endDate: Date
    
    init(stat: any Stat) {
        self.stat = stat
        // dateRange is changed to let, then startDate and endDate will need a value set in the attribute list
        var dateRange = AnyEntry.getEntryDateRange(entryArray: stat.statEntry)
        _startDate = State(initialValue: dateRange.startDate)
        _endDate = State(initialValue: dateRange.endDate)
    }

    var body: some View {
        Form {
            DateRangePicker(startDate: $startDate, endDate: $endDate)

            AnyStat.ReportContent(stat: stat, startDate: $startDate, endDate: $endDate)
        }
    }
}
