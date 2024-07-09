import SwiftUI

struct CounterEntryCard: View {
    var counterEntry: CounterEntry

    var body: some View {
        NavigationLink {
            CounterEntryFormEdit(counterEntry: counterEntry)
        } label: {
            VStack {
                Text("Value: \(counterEntry.value)")
                Text("Timestamp: \(counterEntry.timestamp)")
            }
            .frame(alignment: .leading)
        }
    }
}

#Preview {
    CounterEntryCard(counterEntry: CounterEntry(counterStat: CounterStat(name: "Weight", created: Date.now), entryId: UUID(), value: 1, timestamp: Date.now))
}
