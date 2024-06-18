import SwiftUI
import SwiftData

//TODO: Need to add remaining fields to form
struct CounterForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment (\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var created = Date()
    
    var body: some View {
        
        Button("Cancel"){
            dismiss()
        }
        
        Text("Add Counter")
            .font(.largeTitle)

        
        Form {
            TextField("Title", text: $name)
            
        }
        //TODO: Nav title isn't working because this isn't part of a navigation stack
        .navigationTitle("Add Counter Stat")
        .navigationBarTitleDisplayMode(.inline)
        
        Button("Add Counter"){
            addCounter()
        }
        //TODO: Need to adjust the title to Add / Edit depending whether the Counter has already been added.
    }

    func addCounter() {
        let counter = CounterStat(name: "test name", created: created)
        modelContext.insert(counter)
        try? modelContext.save()
        //TODO: This returns an array of stats meant for ContentView but I dont know how to update that in response to this being called.
        //StatUtility.fetchStats(modelContext: modelContext)
        print(modelContext.sqliteCommand)
        dismiss()
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        let container = try ModelContainer(for: CounterStat.self, configurations: config)
        _ = CounterStat(name: "Weight", created: Date())
        
        return CounterForm()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create error")
    }
}


