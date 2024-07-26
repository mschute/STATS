import SwiftUI

struct CounterEntryFormEdit: View {
    //TODO: Proper way is to use Navigation Path
    @Environment(\.presentationMode) var presentationMode

    @Bindable var counterEntry: CounterEntry
    
    var body: some View {
        Form(content: {
            DatePicker("Timestamp", selection: $counterEntry.timestamp, displayedComponents: [.date, .hourAndMinute])
            TextField("Note", text: $counterEntry.note)
            
            Button("Update", action: saveEntry)
        })
    }

    func saveEntry() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

//#Preview {
//    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
//}
