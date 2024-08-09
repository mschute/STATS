import SwiftUI
import SwiftData

struct DecimalFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    @Environment(\.colorScheme) var colorScheme
    
    @Query(sort: \Category.name) var categories: [Category]
    
    var decimalStat: DecimalStat
    
    @State private var name: String
    @State private var created: Date
    @State private var desc: String
    @State private var unitName: String
    @State private var icon: String
    
    @State private var trackAverage: Bool
    @State private var trackTotal: Bool
    @State private var hasReminder: Bool
    @State private var reminders: [Date]
    @State private var newReminder: Date = Date()
    @State private var interval: String
    
    @State var iconPickerPresented: Bool = false
    
    @State private var newCategory: String = ""
    @State private var chosenCategory: Category? = nil
    @State private var addNewCategory: Bool = false
    
    @State private var isAdvanced: Bool = false
    
    init(decimalStat: DecimalStat) {
        self.decimalStat = decimalStat
        _name = State(initialValue: decimalStat.name)
        _created = State(initialValue: decimalStat.created)
        _desc = State(initialValue: decimalStat.desc)
        _unitName = State(initialValue: decimalStat.unitName)
        _icon = State(initialValue: decimalStat.icon)
        _trackAverage = State(initialValue: decimalStat.trackAverage)
        _trackTotal = State(initialValue: decimalStat.trackTotal)
        _chosenCategory = State(initialValue: decimalStat.category)
        _reminders = State(initialValue: decimalStat.reminder?.reminderTime ?? [])
        _interval = State(initialValue: decimalStat.reminder?.interval.description ?? "")
        _hasReminder = State(initialValue: decimalStat.reminder != nil)
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
                
                Section(header: Text("Basic Information").foregroundColor(.decimal)) {
                    TextField("Name", text: $name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $created, displayedComponents: .date)
                    
                    TextField("Unit name", text: $unitName)
                        .fontWeight(.regular)
                    
                    if isAdvanced {
                        TextField("Description", text: $desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $icon, statColor: .decimal)
                }
                .fontWeight(.medium)
                
                Section(header: Text("Report Configurations").foregroundColor(.decimal)) {
                    Toggle(isOn: $trackAverage) {
                        Text("Calculate Average")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    Toggle(isOn: $trackTotal) {
                        Text("Calculate Total")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                .fontWeight(.medium)
                .tint(.decimal)
                
                FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval, statColor: .decimal, statHighlightColor: .decimalHighlight)
                    .fontWeight(.medium)
                
                if isAdvanced {
                    FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory, statColor: .decimal, statHighlightColor: .decimalHighlight)
                }
                
                Button("Update") {
                }
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .decimal, statHighlightColor: .decimalHighlight))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            updateDecimal()
                        }
                )
            }
            .dismissKeyboardOnTap()
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .frame(maxWidth: .infinity)
    }
    
    private func updateDecimal() {
        decimalStat.name = name
        decimalStat.created = created
        decimalStat.desc = desc
        decimalStat.unitName = unitName
        decimalStat.trackAverage = trackAverage
        decimalStat.trackTotal = trackTotal
        decimalStat.icon = icon
        decimalStat.category = chosenCategory
        
        if hasReminder {
            if let reminder = decimalStat.reminder {
                reminder.interval = Int(interval) ?? 0
                reminder.reminderTime = reminders
            } else {
                let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
                decimalStat.reminder = newReminder
            }
        } else {
            if let reminder = decimalStat.reminder {
                modelContext.delete(reminder)
                decimalStat.reminder = nil
            }
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving decimal stat")
        }
        
        dismiss()
    }
}
