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

//#Preview {
//    CounterCard(stat: CounterStat(name: "Smoking Count", desc: "Test desc", icon: "lasso.badge.sparkles", created: Date(), streak: true, streakFrequency: .daily, reminder: true, tag: "Health"))
//}
