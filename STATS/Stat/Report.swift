import SwiftData
import SwiftUI

// https://www.youtube.com/watch?v=Saw_sZWa4aQ
struct Report: View {
    @Environment(\.colorScheme) var colorScheme
    private var stat: any Stat
    
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    //https://stackoverflow.com/questions/77039981/swiftdata-query-with-predicate-on-relationship-model?ref=simplykyra.com
    //https://developer.apple.com/documentation/swiftdata/filtering-and-sorting-persistent-data
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
