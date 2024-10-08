import SwiftUI

struct CounterEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var counterEntry: CounterEntry
    
    @State private var timestamp: Date
    @State private var note: String
    
    init(counterEntry: CounterEntry) {
        self.counterEntry = counterEntry
        _timestamp = State(initialValue: counterEntry.timestamp)
        _note = State(initialValue: counterEntry.note)
    }
    
    var body: some View {
        VStack {
            TopBar(title: "EDIT ENTRY", topPadding: 20, bottomPadding: 20)
            Form {
                Section(header: Text("Timestamp").foregroundColor(.cyan)) {
                    DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                        .padding(.vertical, 5)
                }
                .fontWeight(.medium)
                
                Section(header: Text("Additional Information").foregroundColor(.cyan).fontWeight(.medium)) {
                    TextField("Note", text: $note)
                }

                Section {
                    Button("Update") {}
                        .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .cyan, statHighlightColor: .counterHighlight))
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    CounterEntry.saveEntry(counterEntry: counterEntry, timestamp: timestamp, note: note, modelContext: modelContext)
                                    Haptics.shared.play(.light)
                                    //Need delay to avoid loading bug
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                        dismiss()
                                    }
                                }
                        )
                }
            }
            
        }
        .dismissKeyboard()
        .globalBackground()
    }
}
