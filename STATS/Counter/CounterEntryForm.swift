import SwiftUI

struct CounterEntryForm: View {
    @Bindable var counterStat: CounterStat
    
    //TODO: To clean this up, create the temp object with blank values rather than individual properties
    @State var value = ""
    @State var timestamp = Date.now
    
    var body: some View {
        Form(content: {
            HStack{
                Text("Value ")
                TextField("Value", text: $value)
                    .keyboardType(.numberPad)
            }
            
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Add", action: addEntry)
        })
    }
    
    func addEntry() {
        //TODO: Will need to add additional guards if each required field is empty
        //TODO: Add alert that a field is empty if they try to submit with an empty field
        guard !value.isEmpty else { return }
        
        let entry = CounterEntry(counterStat: counterStat, entryId: UUID(), value: Int(value) ?? 1, timestamp: timestamp)
        counterStat.statEntry.append(entry)
        
        value = ""
        timestamp = Date.now
        //TODO: Navigate to the History tab after adding
    }
}

#Preview {
    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
}
