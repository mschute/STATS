import SwiftUI

struct DecimalEntryForm: View {
    @EnvironmentObject var selectedDetailTab: StatTabs
    @Environment(\.colorScheme) var colorScheme
    var decimalStat: DecimalStat
    
    @State private var timestamp: Date = Date()
    @State private var note: String = ""
    @State private var value: String = ""
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
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
                    Text("\(decimalStat.unitName)")
                        .fontWeight(.medium)
                }
            }

            Section(header: Text("Additional Information").foregroundColor(.decimal).fontWeight(.medium)) {
                TextField("Note", text: $note)
            }

            Section {
                Button("Add"){}
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

    private func addEntry() {
        let newEntry = DecimalEntry(
            timestamp: timestamp,
            value: Double(value) ?? 0.0,
            note: note
        )
        
        decimalStat.statEntry.append(newEntry)
        selectedDetailTab.selectedDetailTab = .history
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
            addEntry()
        }
    }
}

