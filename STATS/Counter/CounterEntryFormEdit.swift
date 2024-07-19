import SwiftUI

struct CounterEntryFormEdit: View {
    @Environment(\.presentationMode) var presentationMode
    var counterEntry: CounterEntry
    
    @State var timestamp: Date
    
    //State initialValue https://stackoverflow.com/questions/56691630/swiftui-state-var-initialization-issue
    init(counterEntry: CounterEntry) {
        self.counterEntry = counterEntry
        _timestamp = State(initialValue: counterEntry.timestamp)
    }
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Update", action: saveEntry)
        })
    }
    
    //TODO: Navigation is wrong, it is going to Home first and then to history, it should go straight to history
    func saveEntry() {
        counterEntry.timestamp = timestamp
        presentationMode.wrappedValue.dismiss()
    }
}

//#Preview {
//    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
//}
