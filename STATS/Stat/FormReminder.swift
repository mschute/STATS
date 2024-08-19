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
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        if let index = reminders.firstIndex(of: reminder) {
                                            Reminder.deleteReminder(at: IndexSet(integer: index), reminders: &reminders)
                                        }
                                        Haptics.shared.play(.light)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .tint(.cancel)
                        }
                    }
    
                    DatePicker(reminders.isEmpty ? "At" : "And", selection: $newReminder, displayedComponents: [.hourAndMinute])
    
                    Button("Add time") {
                        Reminder.addReminder(reminders: &reminders, newReminder: &newReminder)
                        Haptics.shared.play(.light)
                    }
                    .buttonStyle(StatButtonStyle(fontSize: 15, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: statColor, statHighlightColor: statHighlightColor))
                    .padding(.vertical)
                }
            }
    }
}
