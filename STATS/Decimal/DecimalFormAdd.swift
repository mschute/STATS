import SwiftUI
import SwiftData

struct DecimalFormAdd: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    @Environment(\.colorScheme) var colorScheme
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @State private var name: String = ""
    @State private var created: Date = Date()
    @State private var desc: String = ""
    @State private var unitName: String = ""
    @State private var icon: String = "number.circle.fill"
    @State private var category: Category? = nil
    
    @State private var trackAverage: Bool = false
    @State private var trackTotal: Bool = false
    
    @State private var hasReminder: Bool = false
    @State private var reminders: [Date] = []
    @State private var newReminder: Date = Date()
    @State private var interval: String = ""
    
    @State private var iconPickerPresented: Bool = false
    @State private var newCategory: String = ""
    @State private var chosenCategory: Category? = nil
    @State private var addNewCategory: Bool = false
    
    @State private var isAdvanced: Bool = false
    
    var body: some View {
        VStack {
            TopBar(title: "ADD DECIMAL STAT", topPadding: 0, bottomPadding: 20)
            
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
                
                Section(header: Text("Basic Information").foregroundColor(.decimal)) {
                    TextField("Name", text: $name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $created, displayedComponents: .date)
                    
                    TextField("Unit name", text: $unitName)
                        .fontWeight(.regular)
                    
                    if isAdvanced {
                        TextField("Description", text: $desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $icon, statColor: .decimal)
                }
                .fontWeight(.medium)
                
                Section(header: Text("Report Configurations").foregroundColor(.decimal)) {
                    Toggle(isOn: $trackAverage) {
                        Text("Calculate Average")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    Toggle(isOn: $trackTotal) {
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
                
                Button("Add Decimal") {
                }
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .decimal, statHighlightColor: .decimalHighlight))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            addDecimal()
                            Haptics.shared.play(.light)
                        }
                )
            }
            .dismissKeyboardOnTap()
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func addDecimal() {
        let newReminder = Reminder(interval: Int(interval) ?? 0, reminderTime: reminders)
        let newDecimalStat = DecimalStat(
            name: name,
            created: created,
            desc: desc,
            icon: icon,
            unitName: unitName,
            trackAverage: trackAverage,
            trackTotal: trackTotal,
            reminder: newReminder,
            category: chosenCategory
        )
        
        modelContext.insert(newDecimalStat)
        
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            selectedTab.selectedTab = .statList
        }
    }
}
