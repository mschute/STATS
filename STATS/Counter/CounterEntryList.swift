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
        _entries = Query(filter: CounterEntryList.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue), sort: [SortDescriptor(\.timestamp, order: .reverse)])
    }

    var body: some View {
        List {
            ForEach(entries, id: \.self) { entry in
                CounterEntryCard(counterEntry: entry)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(.vertical, 5)
            }
            .onDelete(perform: deleteItems)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            for index in offsets {
                do {
                    modelContext.delete(entries[index])
                    try modelContext.save()
                } catch {
                        print("Error deleting entry")
                    }
            }
        }
    }
    
    //https://developer.apple.com/documentation/swiftdata/filtering-and-sorting-persistent-data
    private static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<CounterEntry> {
        return #Predicate<CounterEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
}
