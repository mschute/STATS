import SwiftUI

struct DecimalEntryFormEdit: View {
    //TODO: Proper way is to use Navigation Path
    @Environment(\.presentationMode) var presentationMode
    
    //Bindable allows for changes to automatically be saved
    @Bindable var decimalEntry: DecimalEntry
    
    var body: some View {
        Form(content: {
            HStack{
                Text("Value ")
                TextField("Value", value: $decimalEntry.value, format: .number)
                    .keyboardType(.numberPad)
                Text(decimalEntry.stat?.unitName ?? "")
            }
            DatePicker("Timestamp", selection: $decimalEntry.timestamp, displayedComponents: [.date, .hourAndMinute])
            TextField("Note", text: $decimalEntry.note)
            
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
