import SwiftUI

struct DecimalEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
   var decimalEntry: DecimalEntry
    
    @State private var value: Double
    @State private var timestamp: Date
    @State private var note: String
    
    init(decimalEntry: DecimalEntry) {
        self.decimalEntry = decimalEntry
        _value = State(initialValue: decimalEntry.value)
        _timestamp = State(initialValue: decimalEntry.timestamp)
        _note = State(initialValue: decimalEntry.note)
    }
    
    var body: some View {
        Form(content: {
            HStack{
                Text("Value ")
                TextField("Value", value: $value, format: .number)
                    .keyboardType(.numberPad)
                Text(decimalEntry.stat?.unitName ?? "")
            }
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            TextField("Note", text: $note)
            
            Button("Update", action: saveEntry)
        })
    }
    
    func saveEntry() {
        guard !String(decimalEntry.value).isEmpty else { return }
        
        decimalEntry.value = value
        decimalEntry.timestamp = timestamp
        decimalEntry.note = note
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving entry")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

//#Preview {
//    DecimalEntryForm(decimalStat: DecimalStat(name: "Weight", created: Date(), unitName: "KG"), value: "0.0", timestamp: Date())
//}
