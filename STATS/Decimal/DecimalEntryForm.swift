import SwiftUI

struct DecimalEntryForm: View {
    @Bindable var decimalStat: DecimalStat
    
    @State var value = ""
    @State var timestamp = Date.now
    
    @State private var newDecimalEntry = ""
    
    var body: some View {
        Form(content: {
            HStack{
                Text("\(decimalStat.unitName) ")
                TextField("Value", text: $value)
            }
            
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Add", action: addEntry)
        
        })
        
    }
    
    func addEntry() {
        guard newDecimalEntry.isEmpty == false else { return }
        
        withAnimation{
            let entry = DecimalEntry(decimalStat: decimalStat, decimalEntryId: UUID(), timestamp: timestamp, value: Double(value) ?? 0.0)
            decimalStat.statDecimalEntry.append(entry)
            newDecimalEntry = ""
        }
    }
}

#Preview {
    DecimalEntryForm(decimalStat: DecimalStat(name: "Weight", created: Date(), unitName: "KG"), value: String(10.0), timestamp: Date.now)
}
