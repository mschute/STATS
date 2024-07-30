import SwiftData
import SwiftUI

struct CounterEntryForm: View {
    var counterStat: CounterStat
    
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    @State var note = ""
    @State var timestamp = Date.now
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            TextField("Note", text: $note)
            
            Button("Add", action: addEntry)
        })
    }
    
    func addEntry() {
        let entry = CounterEntry(counterStat: counterStat, entryId: UUID(), timestamp: timestamp, note: note)
        //Use append for inserting child objects into the model https://forums.swift.org/t/append-behaviour-in-swiftdata-arrays/72969/4
        counterStat.statEntry.append(entry)
        
        note = ""
        timestamp = Date.now
        selectedDetailTab.selectedDetailTab = .history
    }
}

//#Preview {
//    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
//}
