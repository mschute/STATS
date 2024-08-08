import SwiftUI
import SwiftData

struct DecimalForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    @Environment(\.colorScheme) var colorScheme
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @State var decimalStat: DecimalStat?
    @State var tempDecimalStat: DecimalStat = DecimalStat()
    
    @State private var newCategory: String = ""
    @State private var chosenCategory: Category? = nil
    @State private var addNewCategory: Bool = false
    
    @State var hasReminder: Bool = false
    @State private var reminders: [Date] = []
    @State private var newReminder: Date = Date()
    @State private var interval: String = ""
    
    @State private var iconPickerPresented: Bool = false
    
    var isEditMode: Bool
    @State var isAdvanced: Bool = false
    
    var body: some View {
        VStack {
            if (!isEditMode) {
                TopBar(title: isEditMode ? "" : "Add Decimal Stat", topPadding: 0, bottomPadding: 20)
            }
            Form {
                Section {
                    VStack {
                        Button(isAdvanced ? "Basic Form" : "Advanced Form") {
                            isAdvanced.toggle()
                        }
                        .underline()
                        .fontWeight(.semibold)
                        .foregroundColor(.main)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                Section(header: Text("Basic Information").foregroundColor(.decimal)) {
                    TextField("Name", text: $tempDecimalStat.name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $tempDecimalStat.created, displayedComponents: .date)

                    TextField("Unit name", text: $tempDecimalStat.unitName)
                        .fontWeight(.regular)
                    
                    if isAdvanced {
                        TextField("Description", text: $tempDecimalStat.desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $tempDecimalStat.icon, statColor: .decimal)
                }
                .fontWeight(.medium)
                
                Section(header: Text("Report Configurations").foregroundColor(.decimal)) {
                    Toggle(isOn: $tempDecimalStat.trackAverage) {
                        Text("Calculate Average")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    Toggle(isOn: $tempDecimalStat.trackTotal) {
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
                
                Button(isEditMode ? "Update" : "Add Decimal") {
                    isEditMode ? editDecimal() : addDecimal()
                }
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .decimal, statHighlightColor: .decimalHighlight))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .onAppear {
                if let decimalStat = decimalStat {
                    tempDecimalStat = decimalStat
                    chosenCategory = tempDecimalStat.category
                    
                    if let reminder = tempDecimalStat.reminder {
                        reminders = reminder.reminderTime
                        interval = String(reminder.interval)
                        hasReminder = true
                    } else {
                        reminders = []
                    }
                    //Needs to reset the counter stat here, otherwise it remembers the state from previous session
                } else {
                    tempDecimalStat = DecimalStat()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func addDecimal() {
        let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
        tempDecimalStat.reminder = newReminder
        tempDecimalStat.category = chosenCategory
        
        modelContext.insert(tempDecimalStat)
        
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            selectedTab.selectedTab = .statList
        }
    }
    
    private func editDecimal() {
        if let stat = decimalStat {
            stat.name = tempDecimalStat.name
            stat.desc = tempDecimalStat.desc
            stat.unitName = tempDecimalStat.unitName
            stat.trackAverage = tempDecimalStat.trackAverage
            stat.trackTotal = tempDecimalStat.trackTotal
            stat.icon = tempDecimalStat.icon
            stat.category = chosenCategory
            
            if let reminder = stat.reminder {
                reminder.interval = Int(interval) ?? 0
                reminder.reminderTime = reminders
            }
        }
        dismiss()
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: StatsDecimal.self, configurations: config)
//        let example = StatsDecimal(statId: UUID(), (), title: "Weight", desc: "Decimal tracker to track weight", unitName: "KG")
//
//        return EditDecimalStat(statDecimal: example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create error")
//    }
