import SwiftUI
import SwiftData

struct PictureFormAdd: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @State private var name: String = ""
    @State private var created: Date = Date()
    @State private var desc: String = ""
    @State private var icon: String = "photo"
    @State private var category: Category? = nil
    
    @State private var hasReminder: Bool = false
    @State private var reminders: [Date] = []
    @State private var newReminder: Date = Date()
    @State private var interval: String = "1"
    
    @State private var iconPickerPresented: Bool = false
    
    @State private var newCategory: String = ""
    @State private var chosenCategory: Category? = nil
    @State private var addNewCategory: Bool = false
    @State private var isAdvanced: Bool = false
    
    var body: some View {
        VStack {
            TopBar(title: "ADD PICTURE STAT", topPadding: 20, bottomPadding: 20)
            
            Form {
                Section {
                    VStack {
                        Button(isAdvanced ? "Basic Form" : "Advanced Form") {
                            isAdvanced.toggle()
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
                
                Section(header: Text("Basic Information").foregroundColor(.teal)) {
                    TextField("Name", text: $name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $created, displayedComponents: .date)
                    
                    if isAdvanced {
                        TextField("Description", text: $desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $icon, statColor: .teal)
                }
                .fontWeight(.medium)
                
                FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval, statColor: .teal, statHighlightColor: .pictureHighlight)
                    .fontWeight(.medium)
                
                if isAdvanced {
                    FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory, statColor: .teal, statHighlightColor: .pictureHighlight)
                }
                
                Button("Add Picture") {
                }
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .teal, statHighlightColor: .pictureHighlight))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            PictureStat.addPicture(name: name, created: created, desc: desc, icon: icon, hasReminder: hasReminder, interval: interval, reminders: reminders, chosenCategory: chosenCategory, modelContext: modelContext)
                            Haptics.shared.play(.light)
                            dismiss()
                            //Need delay to avoid loading bug
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                selectedTab.selectedTab = .statList
                            }
                        }
                )
            }
            
            .navigationBarTitleDisplayMode(.inline)
        }
        .dismissKeyboard()
        .globalBackground()
        .frame(maxWidth: .infinity)
    }
}
