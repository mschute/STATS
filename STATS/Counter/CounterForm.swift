import SwiftData

import SwiftUI

struct CounterForm: View {
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @State var counterStat: CounterStat?
    @State var tempCounterStat: CounterStat = CounterStat(name: "", desc: "", icon: "", created: Date(), reminder: nil, category: nil)
    
    @State private var newCategory: String = ""
    @State private var chosenCategory: Category? = nil
    @State private var addNewCategory: Bool = false
    
    @State var hasReminder: Bool = false
    @State private var reminders: [Date] = []
    @State private var newReminder: Date = Date()
    
    @State private var interval: String = ""
    
    @State private var iconPickerPresented: Bool = false
    @State private var icon = "network"
    
    var isEditMode: Bool
    @State var isAdvanced: Bool = false
    
    var body: some View {
        VStack {
            Text(isEditMode ? "" : "Add Counter Stat")
                .font(.largeTitle)
            
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
                TextField("Name", text: $tempCounterStat.name)
                
                if isAdvanced {
                    TextField("Description", text: $tempCounterStat.desc)
                }
                
                FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $icon)
            }
            
            FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval)
            
            
            if isAdvanced {
                FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory)
            }
            
            if isEditMode {
                Button("Update") {
                    editCounter()
                }
                .padding()
                .buttonStyle(.plain)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            } else {
                Button("Add Counter") {
                    addCounter()
                }
                .padding()
                .buttonStyle(.plain)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            
        }
        .onAppear {
            if let counterStat = counterStat {
                tempCounterStat = counterStat
                icon = tempCounterStat.icon
                chosenCategory = tempCounterStat.category
                
                if let reminder = tempCounterStat.reminder {
                    reminders = reminder.reminderTime
                    interval = String(reminder.interval)
                    hasReminder = true
                } else {
                    reminders = []
                }
                //Needs to reset the counter stat here, otherwise it remembers the state from previous session
            } else {
                tempCounterStat = CounterStat(name: "", desc: "", icon: "", created: Date(), reminder: nil, category: nil)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addCounter() {
        tempCounterStat.icon = icon
        
        let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
        tempCounterStat.reminder = newReminder
        tempCounterStat.category = chosenCategory
        
        modelContext.insert(tempCounterStat)
        
        //TODO: If time, polish, there is a delay in the dismiss
        
        dismiss()
        
        //Delaying the call https://www.hackingwithswift.com/example-code/system/how-to-run-code-after-a-delay-using-asyncafter-and-perform
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            selectedTab.selectedTab = .statList
        }
    }
    
    private func editCounter() {
        if let stat = counterStat {
            stat.name = tempCounterStat.name
            stat.desc = tempCounterStat.desc
            stat.icon = icon
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
//        let config = ModelConfiguration(isStoredInMemoryOnly: false)
//        let container = try ModelContainer(for: CounterStat.self, configurations: config)
//        _ = CounterStat(name: "Weight", created: Date())
//
//        return CounterForm(statsDataStore: StatsDataStore(modelContext: ModelContext(ModelContainer)), name: "", created: Date)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create error")
//    }
//}


