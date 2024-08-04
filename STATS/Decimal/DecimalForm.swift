import SwiftUI
import SwiftData

struct DecimalForm: View {
    @Environment(\.modelContext) var modelContext
    //TODO: Should I add presentationMode?
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
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
            Text(isEditMode ? "" : "Add Decimal Stat")
                .font(.largeTitle)
            
            //TODO: Should I abstract this out?
            if !isAdvanced {
                Button("Advanced Form") {
                    isAdvanced = true
                }
                .padding()
            } else {
                Button("Basic Form") {
                    isAdvanced = false
                }
                .padding()
            }
        }
        
        
        Form {
            Section(header: Text("Basic Information")) {
                TextField("Name", text: $tempDecimalStat.name)
                DatePicker("Created", selection: $tempDecimalStat.created, displayedComponents: .date)
                    .datePickerStyle(.compact)
                TextField("Unit name", text: $tempDecimalStat.unitName)
                
                if isAdvanced {
                    TextField("Description", text: $tempDecimalStat.desc)
                }
                
                FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $tempDecimalStat.icon)
            }
            
            //TODO: Add tooltip explaining this section?
            Section(header: Text("Report Configurations")) {
                Toggle("Track Average", isOn: $tempDecimalStat.trackAverage)
                Toggle("Track Total", isOn: $tempDecimalStat.trackTotal)
            }
            
            FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval)
            
            
            if isAdvanced {
                FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory)
            }
            
            if isEditMode {
                Button("Update") {
                    editDecimal()
                }
                .padding()
                .buttonStyle(.plain)
                .cornerRadius(10)
            } else {
                Button("Add Decimal") {
                    addDecimal()
                }
                .padding()
                .buttonStyle(.plain)
                .cornerRadius(10)
            }
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
                tempDecimalStat = DecimalStat(name: "", created: Date(), desc: "", icon: "network", unitName: "", trackAverage: false, trackTotal: false, reminder: nil, category: nil)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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
