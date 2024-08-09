import SwiftUI

struct DecimalEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
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
        TopBar(title: "Edit Entry", topPadding: 0, bottomPadding: 20)
        Form {
            Section(header: Text("Timestamp").foregroundColor(.decimal)) {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                    .padding(.vertical, 5)
            }
            .fontWeight(.medium)
            
            Section(header: Text("Value").foregroundColor(.decimal).fontWeight(.medium)) {
                HStack {
                    TextField("Value", value: $value, format: .number)
                        .keyboardType(.numberPad)
                    Text(decimalEntry.stat?.unitName ?? "")
                        .fontWeight(.medium)
                }
            }

            Section(header: Text("Additional Information").foregroundColor(.decimal).fontWeight(.medium)) {
                TextField("Note", text: $note)
            }
            
            Section {
                Button("Update") {}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .decimal, statHighlightColor: .decimalHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                saveEntry()
                            }
                    )
            }
        }
        .dismissKeyboardOnTap()
    }

    private func saveEntry() {
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
            dismiss()
        }
    }
}
