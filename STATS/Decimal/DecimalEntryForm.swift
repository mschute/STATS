import SwiftUI

struct DecimalEntryForm: View {
    @Environment(\.modelContext) private var modelContext
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
            Section(header: Text("Timestamp").foregroundColor(.mint)) {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                    .padding(.vertical, 5)
            }
            .fontWeight(.medium)
            
            Section(header: Text("Value").foregroundColor(.mint).fontWeight(.medium)) {
                HStack {
                    TextField("Value", text: $value)
                        .keyboardType(.decimalPad)
                    Text("\(decimalStat.unitName)")
                        .fontWeight(.medium)
                }
            }

            Section(header: Text("Additional Information").foregroundColor(.mint).fontWeight(.medium)) {
                TextField("Note", text: $note)
            }

            Section {
                Button("Add"){}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .mint, statHighlightColor: .decimalHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                DecimalEntry.addEntry(decimalStat: decimalStat, timestamp: timestamp, value: value, note: note, alertMessage: &alertMessage, showAlert: &showAlert, modelContext: modelContext)
                                if !showAlert {
                                    Haptics.shared.play(.light)
                                    selectedDetailTab.selectedDetailTab = .history
                                }
                            }
                    )
            }
        }
        .dismissKeyboard()
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                Haptics.shared.play(.light)
            }
        }
    }
}
