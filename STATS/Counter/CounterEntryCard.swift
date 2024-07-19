import SwiftUI

struct CounterEntryCard: View {
    var counterEntry: CounterEntry

    var body: some View {
        NavigationLink {
            CounterEntryFormEdit(counterEntry: counterEntry)
        } label: {
            VStack {
                Text("Timestamp: \(counterEntry.timestamp)")
            }
            .frame(alignment: .leading)
        }
    }
}

//#Preview {
//    CounterEntryCard(counterEntry: CounterEntry(counterStat: CounterStat(name: "Weight", desc: "Test description", icon: "lasso.badge.sparkles", created: Date(), streak: true, streakFrequency: .daily, reminder: true, tag: "Health"), entryId: UUID(), value: 1, timestamp: Date.now))
//}
