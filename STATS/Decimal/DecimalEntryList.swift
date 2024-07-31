import SwiftUI
import SwiftData

struct DecimalEntryList: View {
    @Environment(\.modelContext) var modelContext
    @Query private var entries: [DecimalEntry]
    //https://forums.developer.apple.com/forums/thread/123920?answerId=387111022#387111022
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    init (id: PersistentIdentifier, startDate: Binding<Date>, endDate: Binding<Date>) {
        self._startDate = startDate
        self._endDate = endDate
        
        //https://developer.apple.com/documentation/swiftui/binding/wrappedvalue
        _entries = Query(filter: DecimalEntryList.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue), sort: [SortDescriptor(\.timestamp, order: .reverse)])
    }
    
    var body: some View {
        List {
            ForEach(entries) { entry in
                DecimalEntryCard(decimalEntry: entry)
            }
            .onDelete(perform: deleteItems)
        }
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
    private static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<DecimalEntry> {
        return #Predicate<DecimalEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
}
