import SwiftUI

struct CounterEntryForm: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var selectedDetailTab: StatTabs
    var counterStat: CounterStat
    
    @State private var timestamp: Date = Date()
    @State private var note: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Timestamp").foregroundColor(.cyan)) {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                    .padding(.vertical, 5)
            }
            .fontWeight(.medium)
            
            Section(header: Text("Additional Information").foregroundColor(.cyan).fontWeight(.medium)) {
                TextField("Note", text: $note)
            }

            Section {
                Button("Add") {}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .cyan, statHighlightColor: .counterHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                CounterEntry.addEntry(counterStat: counterStat, timestamp: timestamp, note: note, modelContext: modelContext)
                                Haptics.shared.play(.light)
                                selectedDetailTab.selectedDetailTab = .history
                            }
                    )
            }
        }
        .dismissKeyboard()
    }
}
