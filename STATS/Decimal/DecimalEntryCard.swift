import SwiftUI

struct DecimalEntryCard: View {
    var decimalEntry: DecimalEntry
    
    var body: some View {
        NavigationLink {
            DecimalEntryFormEdit(decimalEntry: decimalEntry)
        } label: {
            VStack {
                Text("Value: \(decimalEntry.value) \(decimalEntry.decimalStat.unitName)")
                Text("Timestamp: \(decimalEntry.timestamp)")
            }
            .frame(alignment: .leading)
        }
    }
}

#Preview {
    DecimalEntryCard(decimalEntry: DecimalEntry(decimalStat: DecimalStat(name: "Weight", created: Date.now, unitName: "KG"), entryId: UUID(), timestamp: Date.now, value: 55.0))
}
