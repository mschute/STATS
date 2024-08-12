import SwiftData
import SwiftUI

struct Report: View {
    @Environment(\.colorScheme) var colorScheme
    var stat: any Stat
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    init(stat: any Stat) {
        self.stat = stat
        let dateRange = AnyStat.getEntryDateRange(entryArray: stat.statEntry)
        _startDate = State(initialValue: dateRange.startDate)
        _endDate = State(initialValue: dateRange.endDate)
    }

    var body: some View {
        ScrollView {
            DateRangePicker(startDate: $startDate, endDate: $endDate)
                .formSectionMimic()
            StatUtility.ReportContent(stat: stat, startDate: $startDate, endDate: $endDate)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .dark ? Color.black : Color(UIColor.systemGray6))
    }
}
