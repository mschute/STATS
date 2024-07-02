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
    
    //TODO: Need to inject Entry Card here
    var body: some View {
        List {
            ForEach(entries) { entry in
                VStack(alignment: .leading) {
                    Text("\(entry.value)")
                        .font(.headline)
                    
                    Text("\(entry.timestamp)")
                }
            }
        }
    }
    
    //https://developer.apple.com/documentation/swiftdata/filtering-and-sorting-persistent-data
    private static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<DecimalEntry> {
        return #Predicate<DecimalEntry> {
            entry in entry.decimalStat.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
}
