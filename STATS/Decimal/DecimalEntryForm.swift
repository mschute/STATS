import SwiftUI

struct DecimalEntryForm: View {
    @Bindable var decimalStat: DecimalStat
    //TODO: Why is this bindable but I have it for State for passing in stat type elsewhere?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    @State var value = ""
    @State var note = ""
    @State var timestamp = Date.now
    
    //TODO: Need to add note field to DecimalEntry
    var body: some View {
        Form(content: {
            HStack{
                Text("\(decimalStat.unitName) ")
                TextField("Value", text: $value)
                    .keyboardType(.decimalPad)
            }
            
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Add", action: addEntry)
        })
        
    }
    
    func addEntry() {
        guard !value.isEmpty else { return }
        //TODO: Add alert that a field is empty if they try to submit with an empty field
        
        let entry = DecimalEntry(decimalStat: decimalStat, entryId: UUID(), timestamp: timestamp, value: Double(value) ?? 0.0, note: note)
        decimalStat.statEntry.append(entry)
        
        value = ""
        note = ""
        timestamp = Date.now
        selectedDetailTab.selectedDetailTab = .history
    }
}

//#Preview {
//    DecimalEntryForm(decimalStat: DecimalStat(name: "Weight", created: Date(), unitName: "KG"), value: String(10.0), timestamp: Date.now)
//}
