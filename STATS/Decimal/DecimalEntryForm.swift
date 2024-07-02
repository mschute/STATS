import SwiftUI

struct DecimalEntryForm: View {
    @Bindable var decimalStat: DecimalStat
    
    @State var value = ""
    @State var timestamp = Date.now
    
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
        
        let entry = DecimalEntry(decimalStat: decimalStat, entryId: UUID(), timestamp: timestamp, value: Double(value) ?? 0.0)
        decimalStat.statEntry.append(entry)
        
        value = ""
        timestamp = Date.now
        //TODO: Navigate to history page
    }
}

#Preview {
    DecimalEntryForm(decimalStat: DecimalStat(name: "Weight", created: Date(), unitName: "KG"), value: String(10.0), timestamp: Date.now)
}
