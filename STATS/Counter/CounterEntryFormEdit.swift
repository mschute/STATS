import SwiftUI

struct CounterEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode

    var counterEntry: CounterEntry
    
    @State private var timestamp: Date
    @State private var note: String
    
    init(counterEntry: CounterEntry) {
        self.counterEntry = counterEntry
        _timestamp = State(initialValue: counterEntry.timestamp)
        _note = State(initialValue: counterEntry.note)
    }
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            TextField("Note", text: $note)
            
            Button("Update", action: saveEntry)
        })
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

//#Preview {
//    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
//}
