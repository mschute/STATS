import SwiftUI
import SwiftData

//TODO: Need to add remaining fields to form
struct CounterForm: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @Binding var selectedTab: Int
    
    @State private var name = ""
    @State private var created = Date()
    
    var body: some View {
            Text("Add Counter")
                .font(.largeTitle)

            
            Form {
                TextField("Title", text: $name)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            
            Button("Add Counter"){
               addCounter(name: name, created: created)
            }
            .padding()
            .buttonStyle(.plain)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            
            Spacer()

            //TODO: Need to adjust the title to Add / Edit depending whether the Counter has already been added.
    }
    
    func addCounter(name: String, created: Date) {
        let counter = CounterStat(name: name, created: created)
        modelContext.insert(counter)
        dismiss()
        selectedTab = 1
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


