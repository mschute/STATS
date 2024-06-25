import SwiftUI
import SwiftData

//TODO: Need to add remaining fields to form
struct CounterForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State var counterStat: CounterStat?
    
    @State var tempCounterStat: CounterStat = CounterStat(name: "", created: Date())
    
    var isEditMode: Bool
    
    @Binding var selectedTab: Int
    
    var body: some View {
        Text(isEditMode ? "" : "Add Counter Stat")
                .font(.largeTitle)

            Form {
                TextField("Name", text: $tempCounterStat.name )
                
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
                addCounter(name: tempCounterStat.name, created: Date())
                }
                .padding()
                .buttonStyle(.plain)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
            Spacer()

    }
    
    private func addCounter(name: String, created: Date) {
        let counter = CounterStat(name: name, created: created)
        modelContext.insert(counter)
        dismiss()
        selectedTab = 1
    }
    
    private func editCounter(name: String) {
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


