import SwiftUI

struct ReminderSection: View {
    @Binding var hasReminder: Bool
    @Binding var reminders: [Date]
    @Binding var newReminder: Date
    
    @Binding var interval: String
    
    var body: some View {
        Section(header: Text("Reminder")) {
            Toggle("Reminder", isOn: $hasReminder)
            
            if hasReminder {
                HStack {
                    Text("Every")
                    
                    TextField("Value", text: $interval)
                        .keyboardType(.numberPad)
                    //Dismiss keyboard tips: https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
                    Text("Day(s)")
                }
                
                List {
                    ForEach(reminders, id: \.self) { reminder in
                        Text(reminder, style: .time)
                    }
                    .onDelete(perform: deleteReminder)
                }
                
                DatePicker(reminders.isEmpty ? "At" : "And", selection: $newReminder, displayedComponents: [.hourAndMinute])
                
                Button("Add reminder time") {
                    addReminder()
                }
            }
        }
    }
    
    //TODO: Should I extract these functions outside of the view?
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

//#Preview {
//    ReminderSection()
//}
