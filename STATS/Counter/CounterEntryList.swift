import SwiftData
import SwiftUI

struct CounterEntryList: View {
    @Environment(\.modelContext) var modelContext
    @Query private var entries: [CounterEntry]
    
    //https://forums.developer.apple.com/forums/thread/123920?answerId=387111022#387111022
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    init (id: PersistentIdentifier, startDate: Binding<Date>, endDate: Binding<Date>) {
        self._startDate = startDate
        self._endDate = endDate
        
        //https://developer.apple.com/documentation/swiftui/binding/wrappedvalue
        _entries = Query(filter: CounterEntry.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue), sort: [SortDescriptor(\.timestamp, order: .reverse)])
    }

    var body: some View {
        if !entries.isEmpty {
            List {
                ForEach(entries, id: \.self) { entry in
                    CounterEntryCard(counterEntry: entry)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .padding(.vertical, 5)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                if let index = entries.firstIndex(of: entry) {
                                    CounterEntry.deleteItems(offsets: IndexSet(integer: index), entries: entries, modelContext: modelContext)
                                }
                                Haptics.shared.play(.light)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.cancel)
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            Section(header: Text("")) {
                Text("No available entries")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
