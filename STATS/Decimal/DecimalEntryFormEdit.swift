import SwiftUI

struct DecimalEntryFormEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @Bindable var decimalEntry: DecimalEntry
    
    var body: some View {
        Form(content: {
            HStack{
                Text("Value ")
                TextField("Value", value: $decimalEntry.value, format: .number)
                    .keyboardType(.numberPad)
                Text(decimalEntry.decimalStat?.unitName ?? "")
            }
            DatePicker("Timestamp", selection: $decimalEntry.timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Update", action: saveEntry)
        })
    }
    
    func saveEntry() {
        guard !String(decimalEntry.value).isEmpty else { return }
        presentationMode.wrappedValue.dismiss()
    }
}

//#Preview {
//    DecimalEntryForm(decimalStat: DecimalStat(name: "Weight", created: Date(), unitName: "KG"), value: "0.0", timestamp: Date())
//}
