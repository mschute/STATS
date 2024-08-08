import SwiftUI

struct FormReminder: View {
    @Binding var hasReminder: Bool
    @Binding var reminders: [Date]
    @Binding var newReminder: Date
    @Binding var interval: String
    
    @Environment(\.colorScheme) var colorScheme
    var statColor: Color
    var statHighlightColor: Color
    
    var body: some View {
            Section(header: Text("Reminder").foregroundColor(statColor)) {
                Toggle(isOn: $hasReminder) {
                    Text("Reminder")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .tint(statColor)
    
                if hasReminder {
                    HStack {
                        Text("Every")
                        TextField("Value", text: $interval)
                            .fontWeight(.light)
                            .keyboardType(.numberPad)
                            .frame(width: 60)
                            .padding(5)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
                            .frame(alignment: .trailing)
                            .multilineTextAlignment(.center)
                        //Dismiss keyboard tips: https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
                        Text("Day(s)")
                    }
                    if (!reminders.isEmpty) {
                        Text("At")
                            .fontWeight(.medium)
                    }
                    List {
                        ForEach(reminders, id: \.self) { reminder in
                            Text(reminder, style: .time)
                                .fontWeight(.regular)
                                .padding(.leading, 10)
                        }
                        .onDelete(perform: deleteReminder)
                    }
    
                    DatePicker(reminders.isEmpty ? "At" : "And", selection: $newReminder, displayedComponents: [.hourAndMinute])
    
                    Button("Add time") {
                        addReminder()
                    }
                    .buttonStyle(StatButtonStyle(fontSize: 15, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: statColor, statHighlightColor: statHighlightColor))
                    .padding(.vertical)
                }
            }
    }
    
    private func addReminder() {
        reminders.append(newReminder)
        sortReminders()
    }
    
    private func deleteReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
        sortReminders()
    }
    
    private func sortReminders() {
        reminders.sort(by: { $0 < $1 } )
    }
}
