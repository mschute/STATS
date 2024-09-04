import SwiftUI

struct DecimalEntryFormEdit: View {
    @Environment(\.modelContext) var modelContext
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
        VStack {
            TopBar(title: "EDIT ENTRY", topPadding: 20, bottomPadding: 20)
            Form {
                Section(header: Text("Timestamp").foregroundColor(.mint)) {
                    DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                        .padding(.vertical, 5)
                }
                .fontWeight(.medium)
                
                Section(header: Text("Value").foregroundColor(.mint).fontWeight(.medium)) {
                    HStack {
                        TextField("Value", text: $value)
                            .keyboardType(.decimalPad)
                        Text(decimalEntry.stat?.unitName ?? "")
                            .fontWeight(.medium)
                    }
                }

                Section(header: Text("Additional Information").foregroundColor(.mint).fontWeight(.medium)) {
                    TextField("Note", text: $note)
                }
                
                Section {
                    Button("Update") {}
                        .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .mint, statHighlightColor: .decimalHighlight))
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    DecimalEntry.saveEntry(decimalEntry: decimalEntry, value: value, timestamp: timestamp, note: note, alertMessage: &alertMessage, showAlert: &showAlert, modelContext: modelContext)

                                    Haptics.shared.play(.light)
                                    //Need delay to avoid loading bug
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                        dismiss()
                                    }
                                }
                        )
                }
            }
            
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    Haptics.shared.play(.light)
                }
            }
        }
        .dismissKeyboard()
        .globalBackground()
    }
}
