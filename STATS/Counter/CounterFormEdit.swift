import SwiftData
import SwiftUI

struct CounterFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @Query(sort: \Category.name) var categories: [Category]
    
    var counterStat: CounterStat
    
    @State private var name: String
    @State private var created: Date
    @State private var desc: String
    @State private var icon: String
    
    @State private var hasReminder: Bool
    @State private var reminders: [Date]
    @State private var newReminder: Date = Date()
    @State private var interval: String
    
    @State private var iconPickerPresented: Bool = false
    
    @State private var newCategory: String = ""
    @State private var chosenCategory: Category? = nil
    @State private var addNewCategory: Bool = false
    
    @State private var isAdvanced: Bool = false
    
    init(counterStat: CounterStat) {
        self.counterStat = counterStat
        _name = State(initialValue: counterStat.name)
        _created = State(initialValue: counterStat.created)
        _desc = State(initialValue: counterStat.desc)
        _icon = State(initialValue: counterStat.icon)
        _chosenCategory = State(initialValue: counterStat.category)
        
        if let reminder = counterStat.reminder {
            _reminders = State(initialValue: reminder.reminderTime)
            _interval = State(initialValue: String(reminder.interval))
            _hasReminder = State(initialValue: true)
        } else {
            _reminders = State(initialValue: [])
            _interval = State(initialValue: "0")
            _hasReminder = State(initialValue: false)
        }
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    VStack {
                        Button(isAdvanced ? "Basic Form" : "Advanced Form") {
                        }
                        .underline()
                        .fontWeight(.semibold)
                        .foregroundColor(.main)
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    isAdvanced.toggle()
                                }
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section(header: Text("Basic Information").foregroundColor(.counter)) {
                    TextField("Name", text: $name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $created, displayedComponents: .date)
                    
                    if isAdvanced {
                        TextField("Description", text: $desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $icon, statColor: .counter)
                }
                .fontWeight(.medium)
                
                FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval, statColor: .counter, statHighlightColor: .counterHighlight)
                    .fontWeight(.medium)
                
                if isAdvanced {
                    FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory, statColor: .counter, statHighlightColor: .counterHighlight)
                }
                
                Button("Update") {}
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .counter, statHighlightColor: .counterHighlight))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            updateCounter()
                        }
                )
            }
            .dismissKeyboardOnTap()
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func updateCounter() {
        counterStat.name = name
        counterStat.created = created
        counterStat.desc = desc
        counterStat.icon = icon
        counterStat.category = chosenCategory
        
        if hasReminder {
            if let reminder = counterStat.reminder {
                reminder.interval = Int(interval) ?? 0
                reminder.reminderTime = reminders
            } else {
                let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
                counterStat.reminder = newReminder
            }
        } else {
            if let reminder = counterStat.reminder {
                modelContext.delete(reminder)
                counterStat.reminder = nil
            }
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving counter stat")
        }
        
        dismiss()
    }
}
