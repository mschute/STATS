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
        _reminders = State(initialValue: counterStat.reminder?.reminderTime ?? [])
        _interval = State(initialValue: counterStat.reminder?.interval.description ?? "1")
        _hasReminder = State(initialValue: counterStat.reminder != nil)
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
                                    Haptics.shared.play(.light)
                                }
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section(header: Text("Basic Information").foregroundColor(.cyan)) {
                    TextField("Name", text: $name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $created, displayedComponents: .date)
                    
                    if isAdvanced {
                        TextField("Description", text: $desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $icon, statColor: .cyan)
                }
                .fontWeight(.medium)
                
                FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval, statColor: .cyan, statHighlightColor: .counterHighlight)
                    .fontWeight(.medium)
                
                if isAdvanced {
                    FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory, statColor: .cyan, statHighlightColor: .counterHighlight)
                }
                
                Button("Update") {}
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .cyan, statHighlightColor: .counterHighlight))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            CounterStat.updateCounter(counterStat: counterStat, name: name, created: created, desc: desc, icon: icon, chosenCategory: chosenCategory, hasReminder: hasReminder, interval: interval, reminders: reminders, modelContext: modelContext)
                            Haptics.shared.play(.light)
                            dismiss()
                        }
                )
            }
            .dismissKeyboard()
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity)
    }
}
