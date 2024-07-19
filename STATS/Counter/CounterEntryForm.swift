import SwiftData
import SwiftUI

struct CounterEntryForm: View {
    @Bindable var counterStat: CounterStat
    //TODO: Why is this bindable but I have it for State for passing in stat type elsewhere?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    //TODO: Create the temp object with blank values rather than individual properties?
    @State var timestamp = Date.now
    
    //TODO: Need to add note field to CounterEntry
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Add", action: addEntry)
        })
    }
    
    func addEntry() {
        //TODO: Will need to add additional guards if each required field is empty
        //TODO: Add alert that a field is empty if they try to submit with an empty field
        
        let entry = CounterEntry(counterStat: counterStat, entryId: UUID(), timestamp: timestamp)
        counterStat.statEntry.append(entry)
        
        timestamp = Date.now
        dismiss()
        selectedDetailTab.selectedDetailTab = .history
        
    }
}

//#Preview {
//    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
//}
