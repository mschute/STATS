import SwiftUI

struct DecimalEntryForm: View {
    @EnvironmentObject var selectedDetailTab: StatTabs
    var decimalStat: DecimalStat
    @State private var entry: DecimalEntry = DecimalEntry()
    @State private var value: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Timestamp").foregroundColor(.decimal)) {
                DatePicker("Timestamp", selection: $entry.timestamp, displayedComponents: [.date, .hourAndMinute])
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
                TextField("Note", text: $entry.note)
            }

            Section {
                Button("Add"){}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .decimal, statHighlightColor: .decimalHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                addEntry()
                            }
                    )
            }
        }
        .dismissKeyboardOnTap()
    }

    private func addEntry() {
        entry.stat = decimalStat
        entry.value = Double(value) ?? 0.0
        
        decimalStat.statEntry.append(entry)
        selectedDetailTab.selectedDetailTab = .history
    }
}
