import SwiftUI

struct DecimalCard: View {
    var stat: DecimalStat
    
    var body: some View {
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
