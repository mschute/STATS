import SwiftUI
import SwiftData

//TODO: Need to add remaining fields to form
struct CounterForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var selectedTab: NavbarTabs
    
    @State var counterStat: CounterStat?
    @State var tempCounterStat: CounterStat = CounterStat(name: "", created: Date())
    
    var isEditMode: Bool
    
    var body: some View {
        Text(isEditMode ? "" : "Add Counter Stat")
            .font(.largeTitle)
        
        Form {
            TextField("Name", text: $tempCounterStat.name)
            
        }
        .onAppear {
            if let counterStat = counterStat {
                tempCounterStat = counterStat
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        if isEditMode {
            Button("Update") {
                editCounter(name: tempCounterStat.name)
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
        Spacer()
        
    }
    
    private func addCounter() {
        modelContext.insert(tempCounterStat)
        selectedTab.selectedTab = .statList
        dismiss()
    }
        
    
        
    
    private func editCounter(name: String) {
        //TODO: After attributes added, just save temp counter onto the counterStat rather than each individual property
        counterStat?.name = name
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


