import SwiftUI

struct CounterDetail: View {
    var stat: CounterStat
    
    var body: some View {
        Text("\(stat.name) Counter Stat Detail")
            .font(.largeTitle)
        StatDetailTabs(stat: stat as any Stat)
        Spacer()
    }
}
