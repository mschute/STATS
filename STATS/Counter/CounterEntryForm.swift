import SwiftData
import SwiftUI

struct CounterEntryForm: View {
    var counterStat: CounterStat
    
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    @State var entry: CounterEntry = CounterEntry()
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $entry.timestamp, displayedComponents: [.date, .hourAndMinute])
            TextField("Note", text: $entry.note)
            
            Button("Add", action: addEntry)
        })
    }
    
    func addEntry() {
        entry.stat = counterStat
        //Use append for inserting child objects into the model https://forums.swift.org/t/append-behaviour-in-swiftdata-arrays/72969/4
        counterStat.statEntry.append(entry)
        
        selectedDetailTab.selectedDetailTab = .history
    }
}

//#Preview {
//    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
//}
