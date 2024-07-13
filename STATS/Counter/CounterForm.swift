import SwiftData
import SymbolPicker
import SwiftUI

struct CounterForm: View {
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @Query(sort: \Category.name) var category: [Category]
    
    @State var counterStat: CounterStat?
    @State var tempCounterStat: CounterStat = CounterStat(name: "", desc: "", icon: "", created: Date(), reminder: nil, categories: nil)
    
    @State private var newCategory: String = ""
    @State private var chosenCategory: [String]? = nil
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
                
                HStack {
                    Text("Icon")
                    Button {
                        iconPickerPresented = true
                    } label: {
                        HStack {
                            Image(systemName: icon)
                            Image(systemName: "chevron.right")
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.black)
                    }
                    .sheet(isPresented: $iconPickerPresented) {
                        SymbolPicker(symbol: $icon)
                    }
                }
            }
            
//            Section(header: Text("Reminder")) {
//                Toggle("Reminder", isOn: $hasReminder)
//                
//                if hasReminder {
//                    HStack {
//                        Text("Every")
//                        
//                        TextField("Value", text: $interval)
//                            .keyboardType(.numberPad)
//                        //Dismiss keyboard tips: https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
//                        Text("Day(s)")
//                    }
//                    
//                    List {
//                        ForEach(reminders, id: \.self) { reminder in
//                            Text(reminder, style: .time)
//                        }
//                        .onDelete(perform: deleteReminder)
//                    }
//                    
//                    DatePicker(reminders.isEmpty ? "At" : "And", selection: $newReminder, displayedComponents: [.hourAndMinute])
//                    
//                    Button("Add reminder time") {
//                        addReminder()
//                    }
//                }
//            }
            

            ReminderSection(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval)
                //TODO: Needs to either select a tag from a dropdown menu or create new tag
                //TODO: Create custom multiple picker with SwiftUI https://www.fline.dev/multi-selector-in-swiftui/
                //Optional picker: https://www.hackingwithswift.com/forums/swiftui/correct-use-of-swiftdata-in-a-picker/25107
            if isAdvanced {
                Section(header: Text("Category")) {
                    Picker("Select a tag", selection: $chosenCategory) {
                        ForEach(category) {
                            option in Text(option.name)
                                .tag(Optional(option))
                        }
                    }
                    
                    if !addNewCategory {
                        Button("Add new tag") {
                            addNewCategory = true
                        }
                    }
                    
                    if addNewCategory {
                        TextField("Add new tag", text: $newCategory)
                        HStack{
                            Button("Add") {
                                addCategory(newCategory: newCategory)
                                newCategory = ""
                                addNewCategory = false
                            }
                            Button("Cancel") {
                                newCategory = ""
                                addNewCategory = false
                            }
                        }
                    }
                }
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
                    
                    if let reminder = tempCounterStat.reminder {
                        reminders = reminder.reminderTime
                        interval = String(reminder.interval)
                        hasReminder = true
                    } else {
                        reminders = []
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    
//    private func addReminder() {
//        reminders.append(newReminder)
//        sortReminders()
//    }
//    
//    private func deleteReminder(at offsets: IndexSet) {
//        reminders.remove(atOffsets: offsets)
//        sortReminders()
//    }
//    
//    private func sortReminders() {
//        reminders.sort(by: { $0 < $1 } )
//    }
    
    private func addCounter() {
        tempCounterStat.icon = icon
        
        var newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
        tempCounterStat.reminder = newReminder
        
        //TODO: Need to add category
        
        modelContext.insert(tempCounterStat)
        selectedTab.selectedTab = .statList
        dismiss()
    }
    
    private func editCounter() {
        if let stat = counterStat {
            stat.name = tempCounterStat.name
            stat.desc = tempCounterStat.desc
            stat.icon = icon
            
            if let reminder = stat.reminder {
                reminder.interval = Int(interval) ?? 0
                reminder.reminderTime = reminders
            }
            //TODO: Need to add category
        }
        dismiss()
    }
    
    //TODO: How do they delete a category?
    //TODO: May need to extract this out to the StatUtility and remove private, make it switchable? (maybe thats not necessary)
    private func addCategory(newCategory: String){
        modelContext.insert(Category(name: newCategory))
        //TODO: Do I need a State Variable to check whether this button was clicked so it will expand a textfield with another button where they can add it? Probably
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


