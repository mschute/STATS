import SwiftUI

struct DecimalEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
   var decimalEntry: DecimalEntry
    
    @State private var value: String
    @State private var timestamp: Date
    @State private var note: String
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    init(decimalEntry: DecimalEntry) {
        self.decimalEntry = decimalEntry
        _value = State(initialValue: String(decimalEntry.value))
        _timestamp = State(initialValue: decimalEntry.timestamp)
        _note = State(initialValue: decimalEntry.note)
    }
    
    var body: some View {
        TopBar(title: "EDIT ENTRY", topPadding: 0, bottomPadding: 20)
        Form {
            Section(header: Text("Timestamp").foregroundColor(.decimal)) {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                    .padding(.vertical, 5)
            }
            .fontWeight(.medium)
            
            Section(header: Text("Value").foregroundColor(.decimal).fontWeight(.medium)) {
                HStack {
                    TextField("Value", text: $value)
                        .keyboardType(.decimalPad)
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
                                validateEntry()
                                Haptics.shared.play(.light)
                            }
                    )
            }
        }
        .dismissKeyboardOnTap()
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        .onAppear() {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.dynamicMainColor(colorScheme: colorScheme)
        }
    }

    private func saveEntry() {
        decimalEntry.value = Double(value) ?? 0.0
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
    
    private func validateEntry() {
        if(value.isEmpty) {
            alertMessage = "Must add value"
            showAlert = true
        } else if (ValidationUtility.moreThanOneDecimalPoint(value: value)) {
            alertMessage = "Invalid value"
            showAlert = true
        } else if (ValidationUtility.numberTooBig(value: value)) {
            alertMessage = "Value is too big"
            showAlert = true
        } else {
            saveEntry()
        }
    }
}
