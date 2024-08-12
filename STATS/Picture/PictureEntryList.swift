import SwiftData
import SwiftUI

struct PictureEntryList: View {
    @Environment(\.modelContext) var modelContext
    @Query private var entries: [PictureEntry]
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    init (id: PersistentIdentifier, startDate: Binding<Date>, endDate: Binding<Date>) {
        self._startDate = startDate
        self._endDate = endDate
        
        _entries = Query(filter: PictureEntryList.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue), sort: [SortDescriptor(\.timestamp, order: .reverse)])
    }
    
    var body: some View {
        List {
            ForEach(entries) { entry in
                PictureEntryCard(pictureEntry: entry)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(.vertical, 5)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            if let index = entries.firstIndex(of: entry) {
                                deleteItems(offsets: IndexSet(integer: index))
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.cancel)
                    }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
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
    
    private static func predicate(id: PersistentIdentifier, startDate: Date, endDate: Date) -> Predicate<PictureEntry> {
        return #Predicate<PictureEntry> {
            entry in entry.stat?.persistentModelID == id && (entry.timestamp >= startDate && entry.timestamp <= endDate)
        }
    }
}
