import SwiftUI

struct DecimalEntryFormEdit: View {
    @Environment(\.presentationMode) var presentationMode
    var decimalEntry: DecimalEntry
    
    @State var value: String
    @State var timestamp: Date
    @State var unitName: String
    
    //State initialValue: https://stackoverflow.com/questions/56691630/swiftui-state-var-initialization-issue
    init(decimalEntry: DecimalEntry) {
        self.decimalEntry = decimalEntry
        _value = State(initialValue: String(decimalEntry.value))
        _timestamp = State(initialValue: decimalEntry.timestamp)
        _unitName = State(initialValue: decimalEntry.decimalStat?.unitName ?? "")
    }
    
    var body: some View {
        Form(content: {
            HStack{
                Text("Value ")
                TextField("Value", text: $value)
                    .keyboardType(.numberPad)
                Text("\(unitName)")
            }
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Update", action: saveEntry)
        })
    }
    
    func saveEntry() {
        guard !value.isEmpty else { return }
        
        decimalEntry.value = Double(value) ?? 0.0
        decimalEntry.timestamp = timestamp
        presentationMode.wrappedValue.dismiss()
    }
}

//#Preview {
//    DecimalEntryForm(decimalStat: DecimalStat(name: "Weight", created: Date(), unitName: "KG"), value: "0.0", timestamp: Date())
//}
