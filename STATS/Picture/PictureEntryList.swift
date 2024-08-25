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
        
        _entries = Query(filter: PictureEntry.predicate(id: id, startDate: startDate.wrappedValue, endDate: endDate.wrappedValue), sort: [SortDescriptor(\.timestamp, order: .reverse)])
    }
    
    var body: some View {
        if !entries.isEmpty {
            List {
                ForEach(entries) { entry in
                    PictureEntryCard(pictureEntry: entry)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .padding(.vertical, 5)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                if let index = entries.firstIndex(of: entry) {
                                    PictureEntry.deleteItems(offsets: IndexSet(integer: index), entries: entries, modelContext: modelContext)
                                }
                                Haptics.shared.play(.light)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.cancel)
                        }
                }
            }
        } else {
            Section(header: Text("")) {
                Text("No available entries")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
