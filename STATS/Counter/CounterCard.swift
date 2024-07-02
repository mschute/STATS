import SwiftUI

struct CounterCard: View {
    var stat: CounterStat
    
    var body: some View {
        NavigationLink {
            CounterDetail(stat: stat)
        } label: {
            Text("\(stat.name) Detail")
        }
    }
}

#Preview {
    CounterCard(stat: CounterStat(name: "Smoking Count", created: Date()))
}
