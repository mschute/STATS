import SwiftUI
import SwiftData

struct DecimalFormEdit: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    @Environment(\.colorScheme) var colorScheme
    
    @Query(sort: \Category.name) var categories: [Category]
    
    var decimalStat: DecimalStat
    
    @State private var name: String
    @State private var created: Date
    @State private var desc: String
    @State private var unitName: String
    @State private var icon: String
    
    @State private var trackAverage: Bool
    @State private var trackTotal: Bool
    @State private var hasReminder: Bool
    @State private var reminders: [Date]
    @State private var newReminder: Date = Date()
    @State private var interval: String
    
    @State var iconPickerPresented: Bool = false
    
    @State private var newCategory: String = ""
    @State private var chosenCategory: Category? = nil
    @State private var addNewCategory: Bool = false
    
    @State private var isAdvanced: Bool = false
    
    init(decimalStat: DecimalStat) {
        self.decimalStat = decimalStat
        _name = State(initialValue: decimalStat.name)
        _created = State(initialValue: decimalStat.created)
        _desc = State(initialValue: decimalStat.desc)
        _unitName = State(initialValue: decimalStat.unitName)
        _icon = State(initialValue: decimalStat.icon)
        _trackAverage = State(initialValue: decimalStat.trackAverage)
        _trackTotal = State(initialValue: decimalStat.trackTotal)
        _chosenCategory = State(initialValue: decimalStat.category)
        
        _reminders = State(initialValue: decimalStat.reminder?.reminderTime ?? [])
        _interval = State(initialValue: decimalStat.reminder?.interval.description ?? "1")
        _hasReminder = State(initialValue: decimalStat.reminder != nil)
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
                
                Section(header: Text("Basic Information").foregroundColor(.mint)) {
                    TextField("Name", text: $name)
                        .fontWeight(.regular)
                    
                    DatePicker("Created", selection: $created, displayedComponents: .date)
                    
                    TextField("Unit name", text: $unitName)
                        .fontWeight(.regular)
                    
                    if isAdvanced {
                        TextField("Description", text: $desc)
                            .fontWeight(.regular)
                    }
                    
                    FormIconPicker(iconPickerPresented: $iconPickerPresented, icon: $icon, statColor: .mint)
                }
                .fontWeight(.medium)
                
                Section(header: Text("Report Configurations").foregroundColor(.mint)) {
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
                .tint(.mint)
                
                FormReminder(hasReminder: $hasReminder, reminders: $reminders, newReminder: $newReminder, interval: $interval, statColor: .mint, statHighlightColor: .decimalHighlight)
                    .fontWeight(.medium)
                
                if isAdvanced {
                    FormCategoryPicker(newCategory: $newCategory, chosenCategory: $chosenCategory, addNewCategory: $addNewCategory, statColor: .mint, statHighlightColor: .decimalHighlight)
                }
                
                Button("Update") {
                }
                .buttonStyle(StatButtonStyle(fontSize: 18, verticalPadding: 15, horizontalPadding: 25, align: .center, statColor: .mint, statHighlightColor: .decimalHighlight))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            DecimalStat.updateDecimal(decimalStat: decimalStat, name: name, created: created, desc: desc, icon: icon, unitName: unitName, trackAverage: trackAverage, trackTotal: trackTotal, hasReminder: hasReminder, interval: interval, reminders: reminders, chosenCategory: chosenCategory, modelContext: modelContext)
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
