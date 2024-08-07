import SwiftData
import SwiftUI

struct PictureForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @State var pictureStat: PictureStat?
    @State var tempPictureStat: PictureStat = PictureStat()
    
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
                TopBar(title: isEditMode ? "" : "Add Picture Stat", topPadding: 0, bottomPadding: 20)
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
                
                Section(header: Text("Basic Information").foregroundColor(.picture)) {
                    TextField("Name", text: $tempPictureStat.name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $tempPictureStat.created, displayedComponents: .date)
                    
                    if isAdvanced {
                        TextField("Description", text: $tempPictureStat.desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $tempPictureStat.icon, statColor: .picture)
                }
                .fontWeight(.medium)
                
                FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval, statColor: .picture)
                    .fontWeight(.medium)
                
                
                if isAdvanced {
                    FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory, statColor: .picture)
                }
                
                Button(isEditMode ? "Update" : "Add Picture") {
                    isEditMode ? editPicture() : addPicture()
                }
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .picture))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .onAppear {
                if let pictureStat = pictureStat {
                    tempPictureStat = pictureStat
                    chosenCategory = tempPictureStat.category
                    
                    if let reminder = tempPictureStat.reminder {
                        reminders = reminder.reminderTime
                        interval = String(reminder.interval)
                        hasReminder = true
                    } else {
                        reminders = []
                    }
                    //Needs to reset the stat here, otherwise it remembers the state from previous session
                } else {
                    tempPictureStat = PictureStat()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func addPicture() {
        
        let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
        tempPictureStat.reminder = newReminder
        tempPictureStat.category = chosenCategory
        
        modelContext.insert(tempPictureStat)
        
        dismiss()
        
        //Delaying the call https://www.hackingwithswift.com/example-code/system/how-to-run-code-after-a-delay-using-asyncafter-and-perform
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            selectedTab.selectedTab = .statList
        }
    }
    
    private func editPicture() {
        if let stat = pictureStat {
            stat.name = tempPictureStat.name
            stat.desc = tempPictureStat.desc
            stat.icon = tempPictureStat.icon
            stat.category = chosenCategory
            
            if let reminder = stat.reminder {
                reminder.interval = Int(interval) ?? 0
                reminder.reminderTime = reminders
            }
        }
        dismiss()
    }
}
