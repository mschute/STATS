import SwiftUI
import SwiftData

struct PictureFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @Query(sort: \Category.name) var categories: [Category]
    
    var pictureStat: PictureStat
    
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
    
    init(pictureStat: PictureStat) {
        self.pictureStat = pictureStat
        _name = State(initialValue: pictureStat.name)
        _created = State(initialValue: pictureStat.created)
        _desc = State(initialValue: pictureStat.desc)
        _icon = State(initialValue: pictureStat.icon)
        _chosenCategory = State(initialValue: pictureStat.category)
        _reminders = State(initialValue: pictureStat.reminder?.reminderTime ?? [])
        _interval = State(initialValue: pictureStat.reminder?.interval.description ?? "")
        _hasReminder = State(initialValue: pictureStat.reminder != nil)
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
                
                Section(header: Text("Basic Information").foregroundColor(.picture)) {
                    TextField("Name", text: $name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $created, displayedComponents: .date)
                    
                    if isAdvanced {
                        TextField("Description", text: $desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $icon, statColor: .picture)
                }
                .fontWeight(.medium)
                
                FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval, statColor: .picture, statHighlightColor: .pictureHighlight)
                    .fontWeight(.medium)
                
                if isAdvanced {
                    FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory, statColor: .picture, statHighlightColor: .pictureHighlight)
                }
                
                Button("Update") {
                }
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .picture, statHighlightColor: .pictureHighlight))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            PictureStat.updatePicture(pictureStat: pictureStat, name: name, created: created, desc: desc, icon: icon, hasReminder: hasReminder, interval: interval, reminders: reminders, chosenCategory: chosenCategory, modelContext: modelContext)
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

