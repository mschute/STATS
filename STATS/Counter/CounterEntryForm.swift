import SwiftData
import SwiftUI

struct CounterEntryForm: View {
    @Bindable var counterStat: CounterStat
    //TODO: Why is this bindable but I have it for State for passing in stat type elsewhere?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    //TODO: Create the temp object with blank values rather than individual properties?
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
        dismiss()
        selectedDetailTab.selectedDetailTab = .history
        
    }
}

//#Preview {
//    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
//}
