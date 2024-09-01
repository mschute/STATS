import SwiftData
import SwiftUI

struct CounterFormAdd: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @State private var name: String = ""
    @State private var created: Date = Date()
    @State private var desc: String = ""
    @State private var icon: String = "goforward"
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
                TopBar(title: "ADD COUNTER STAT", topPadding: 0, bottomPadding: 20)
                Form {
                    Section {
                        VStack {
                            Button(isAdvanced ? "Basic Form" : "Advanced Form") {}
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
                    
                    Section(header: Text("Basic Information").foregroundColor(.counter)) {
                        TextField("Name", text: $name)
                            .fontWeight(.regular)
                        
                            DatePicker("Created", selection: $created, displayedComponents: .date)
                    
                        if isAdvanced {
                            TextField("Description", text: $desc)
                                .fontWeight(.regular)
                        }
                        
                        FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $icon, statColor: .counter)
                    }
                    .fontWeight(.medium)
                    
                    FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval, statColor: .counter, statHighlightColor: .counterHighlight)
                        .fontWeight(.medium)
                    
                    if isAdvanced {
                        FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory, statColor: .counter, statHighlightColor: .counterHighlight)
                    }
                    
                    Button("Add Counter") {}
                    .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .counter, statHighlightColor: .counterHighlight))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                CounterStat.addCounter(hasReminder: hasReminder, interval: interval, reminders: reminders, name: name, created: created, desc: desc, icon: icon, chosenCategory: chosenCategory, modelContext: modelContext)
                                dismiss()
                                //Delaying the call https://www.hackingwithswift.com/example-code/system/how-to-run-code-after-a-delay-using-asyncafter-and-perform
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    selectedTab.selectedTab = .statList
                                        
                                }
                                Haptics.shared.play(.light)
                            }
                    )
                }
                .dismissKeyboard()
                .navigationBarTitleDisplayMode(.inline)
            }
            .frame(maxWidth: .infinity)
    }
}
