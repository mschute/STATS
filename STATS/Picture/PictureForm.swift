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
            Text(isEditMode ? "" : "Add Picture Stat")
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
                TextField("Name", text: $tempPictureStat.name)
                DatePicker("Created", selection: $tempPictureStat.created, displayedComponents: .date)
                    .datePickerStyle(.compact)
                
                if isAdvanced {
                    TextField("Description", text: $tempPictureStat.desc)
                }
                
                FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $tempPictureStat.icon)
            }
            
            FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval)
            
            
            if isAdvanced {
                FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory)
            }
            
            if isEditMode {
                Button("Update") {
                    editPicture()
                }
                .padding()
                .buttonStyle(.plain)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            } else {
                Button("Add Picture") {
                    addPicture()
                }
                .padding()
                .buttonStyle(.plain)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
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
                tempPictureStat = PictureStat(name: "", created: Date(), desc: "", icon: "network", reminder: nil, category: nil)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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

//#Preview {
//    PictureForm()
//}
