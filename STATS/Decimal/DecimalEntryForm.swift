import SwiftUI

struct DecimalEntryForm: View {
    var decimalStat: DecimalStat
    
    @EnvironmentObject var selectedDetailTab: StatTabs
    
    @State var entry: DecimalEntry = DecimalEntry()
    @State var value: String = ""
    
    var body: some View {
        Form(content: {
            HStack{
                Text("\(decimalStat.unitName) ")
                TextField("Value", text: $value)
                    .keyboardType(.decimalPad)
                TextField("Note", text: $entry.note)
            }
            
            DatePicker("Timestamp", selection: $entry.timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Add", action: addEntry)
        })
        
    }
    
    func addEntry() {
        entry.stat = decimalStat
        entry.value = Double(value) ?? 0.0
        
        decimalStat.statEntry.append(entry)
        
        selectedDetailTab.selectedDetailTab = .history
    }
}

//#Preview {
//    DecimalEntryForm(decimalStat: DecimalStat(name: "Weight", created: Date(), unitName: "KG"), value: String(10.0), timestamp: Date.now)
//}
