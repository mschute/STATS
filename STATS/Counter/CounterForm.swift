import SwiftData
import SwiftUI

struct CounterForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @State var counterStat: CounterStat?
    @State var tempCounterStat: CounterStat = CounterStat()
    
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
                TopBar(title: isEditMode ? "" : "ADD COUNTER STAT", topPadding: 0, bottomPadding: 20)
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
                
                Section(header: Text("Basic Information").foregroundColor(.counter)) {
                    TextField("Name", text: $tempCounterStat.name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $tempCounterStat.created, displayedComponents: .date)
                    
                    if isAdvanced {
                        TextField("Description", text: $tempCounterStat.desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $tempCounterStat.icon, statColor: .counter)
                    
                }
                .fontWeight(.medium)
                
                FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval, statColor: .counter, statHighlightColor: .counterHighlight)
                    .fontWeight(.medium)
                
                if isAdvanced {
                    FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory, statColor: .counter, statHighlightColor: .counterHighlight)
                }
                
                Button(isEditMode ? "Update" : "Add Counter") {
                    isEditMode ? editCounter() : addCounter()
                }
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .counter, statHighlightColor: .counterHighlight))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .onAppear {
                if let counterStat = counterStat {
                    tempCounterStat = counterStat
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
                    tempCounterStat = CounterStat()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func addCounter() {
        let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
        tempCounterStat.reminder = newReminder
        tempCounterStat.category = chosenCategory
        
        modelContext.insert(tempCounterStat)
        
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
            stat.icon = tempCounterStat.icon
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
