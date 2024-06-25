import SwiftUI

struct CounterDetail: View {
    var stat: CounterStat

    //https://johncodeos.com/how-to-create-tabs-with-swiftui/
    
    var body: some View {
        Text("\(stat.name) Stat Detail")
            .font(.largeTitle)
        StatDetailTabs(stat: stat as Stat)
        //TODO: This needs to be turned into an Edit page rather than add
        //CounterEntryForm(counterStat: stat, value: "1", timestamp: Date())
    }
}

#Preview {
    CounterDetail(stat: CounterStat(name: "Smoking Count", created: Date()))
}
