import SwiftUI

struct CounterEntryFormEdit: View {
    @Environment(\.presentationMode) var presentationMode
    var counterEntry: CounterEntry
    
    @State var value: String
    @State var timestamp: Date
    
    //State initialValue https://stackoverflow.com/questions/56691630/swiftui-state-var-initialization-issue
    init(counterEntry: CounterEntry) {
        self.counterEntry = counterEntry
        _value = State(initialValue: String(counterEntry.value))
        _timestamp = State(initialValue: counterEntry.timestamp)
    }
    
    var body: some View {
        Form(content: {
            HStack{
                Text("Value ")
                TextField("Value", text: $value)
                    .keyboardType(.numberPad)
            }
            
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Update", action: saveEntry)
        })
    }
    
    func saveEntry() {
        guard !value.isEmpty else { return }
        
        counterEntry.value = Int(value) ?? 1
        counterEntry.timestamp = timestamp
        presentationMode.wrappedValue.dismiss()
    }
}

//#Preview {
//    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
//}
