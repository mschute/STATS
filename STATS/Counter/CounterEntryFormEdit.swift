import SwiftUI

struct CounterEntryFormEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    var counterEntry: CounterEntry
    
    @State var timestamp: Date
    @State var note: String
    
    //State initialValue https://stackoverflow.com/questions/56691630/swiftui-state-var-initialization-issue
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
    
    //TODO: Navigation is wrong, it is going to Home first and then to history, it should go straight to history
    func saveEntry() {
        
        counterEntry.note = note
        counterEntry.timestamp = timestamp
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

//#Preview {
//    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
//}
