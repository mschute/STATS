import SwiftData
import SwiftUI

struct CounterEntryForm: View {
    @EnvironmentObject var selectedDetailTab: StatTabs
    var counterStat: CounterStat
    @State private var entry: CounterEntry = CounterEntry()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Form {
            Section(header: Text("Timestamp").foregroundColor(.counter)) {
                DatePicker("Timestamp", selection: $entry.timestamp, displayedComponents: [.date, .hourAndMinute])
                    .padding(.vertical, 5)
            }
            .fontWeight(.medium)
            
            Section(header: Text("Additional Information").foregroundColor(.counter).fontWeight(.medium)) {
                TextField("Note", text: $entry.note)
            }

            Section {
                Button("Add") {}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .counter, statHighlightColor: .counterHighlight))
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
    //Use append for inserting child objects into the model https://forums.swift.org/t/append-behaviour-in-swiftdata-arrays/72969/4
    private func addEntry() {
        entry.stat = counterStat
        counterStat.statEntry.append(entry)
        selectedDetailTab.selectedDetailTab = .history
    }
}
