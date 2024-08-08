import SwiftUI

struct CounterEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
    //TODO: Should this be changed to dismiss?
    @Environment(\.presentationMode) var presentationMode
    var counterEntry: CounterEntry
    
    @State private var timestamp: Date
    @State private var note: String
    
    //TODO: Why do I have an init, versus tempEntryCounter
    init(counterEntry: CounterEntry) {
        self.counterEntry = counterEntry
        _timestamp = State(initialValue: counterEntry.timestamp)
        _note = State(initialValue: counterEntry.note)
    }
    
    var body: some View {
        TopBar(title: "Edit Entry", topPadding: 0, bottomPadding: 20)
        Form {
            Section(header: Text("Timestamp").foregroundColor(.counter)) {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                    .padding(.vertical, 5)
            }
            .fontWeight(.medium)
            
            Section(header: Text("Additional Information").foregroundColor(.counter).fontWeight(.medium)) {
                TextField("Note", text: $note)
            }

            Section {
                Button("Update", action: saveEntry)
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .counter, statHighlightColor: .counterHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    func saveEntry() {
        counterEntry.timestamp = timestamp
        counterEntry.note = note
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving entry")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
