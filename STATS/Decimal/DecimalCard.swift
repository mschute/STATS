import SwiftUI

struct DecimalCard: View {
    var stat: DecimalStat
    
    var body: some View {
        //TODO: Opps, I may have added a navigation to detail view twice
        NavigationLink {
            DecimalDetail(stat: stat)
        } label: {
            Text("\(stat.name) Detail")
        }
    }
}

#Preview {
    CounterCard(stat: CounterStat(name: "Smoking Count", created: Date()))
}
