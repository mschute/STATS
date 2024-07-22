import SwiftUI

struct DecimalEntryForm: View {
    var decimalStat: DecimalStat
    
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    @State var value = ""
    @State var note = ""
    @State var timestamp = Date.now
    
    var body: some View {
        Form(content: {
            HStack{
                Text("\(decimalStat.unitName) ")
                TextField("Value", text: $value)
                    .keyboardType(.decimalPad)
                TextField("Note", text: $note)
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
