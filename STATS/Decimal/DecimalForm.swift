import SwiftUI
import SwiftData

//TODO: Need to add reamining fields to form
struct DecimalForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @State var decimalStat: DecimalStat?
    @State var tempDecimalStat: DecimalStat = DecimalStat(name: "", created: Date(), unitName: "")
    
    var isEditMode: Bool
    
    var body: some View {
        Text(isEditMode ? "" : "Add Decimal Stat")
            .font(.largeTitle)
        
        Form {
            TextField("Title", text: $tempDecimalStat.name)
            
            TextField("Unit name", text: $tempDecimalStat.unitName)
        }
        .onAppear {
            if let decimalStat = decimalStat {
                tempDecimalStat = decimalStat
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        if isEditMode {
            Button("Update"){
                editDecimal(name: tempDecimalStat.name, unitName: tempDecimalStat.unitName)
            }
            .padding()
            .buttonStyle(.plain)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
        } else {
            Button("Add Decimal"){
                addDecimal()
            }
            .padding()
            .buttonStyle(.plain)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
        }
    }

    private func addDecimal() {
        modelContext.insert(tempDecimalStat)
        selectedTab.selectedTab = .statList
        dismiss()
    }
    
    private func editDecimal(name: String, unitName: String) {
        decimalStat?.name = name
        decimalStat?.unitName = unitName
        dismiss()
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: StatsDecimal.self, configurations: config)
//        let example = StatsDecimal(statId: UUID(), (), title: "Weight", desc: "Decimal tracker to track weight", unitName: "KG")
//
//        return EditDecimalStat(statDecimal: example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create error")
//    }
