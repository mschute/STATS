import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    
    @Query private var decimals: [DecimalStat]
    @Query private var counters: [CounterStat]
    
    @State private var name = ""
    @State private var date = Date()
    @State private var created = Date()
    @State private var unitName = ""
    @State private var value = ""
    
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-present-a-new-view-using-sheets
    @State private var addForm = false
    
    @State private var stats: [AnyStat] = []
    
    init() {
        // Aggregate arrays https://bugfender.com/blog/swiftui-lists/
        decimals.forEach { stat in stats.append(AnyStat(stat: stat)) }
        counters.forEach { stat in stats.append(AnyStat(stat: stat)) }
    }
    
    var body: some View {
        //TODO: Should our stat cards be part of a navigation stack? Need to solve applying path to wrapper class
        NavigationStack(path: $path) {
            List {
                ForEach(stats) { item in
                    NavigationLink(destination: item.stat.detailView){
                        StatUtility.Card(stat: item.stat)
                    }
                    

                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Stat List")
            .toolbar {
                //TODO: Move plus button to the bottom navbar?
                ToolbarItem{
                    Menu(content: {
                        Button("Add Counter", systemImage: "arrow.counterclockwise") {
                            addForm.toggle()
                        }
                        Button(action: addDecimal) {
                            Label("Add Decimal", systemImage: "number")
                        }
                    }, label: {
                        Label("Add Stat", systemImage: "plus")
                    })
                }
                
                ToolbarItem{
                    Menu {
                        //TODO: Need to implement sort
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                    //TODO: Implement filter?
                }
                
//                ToolbarItem{
//                    Button("Add counter") {
//                        addCounter()
//                    }
//                }
            }
            .sheet(isPresented: $addForm, content: {
                CounterForm()
            })
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            // Uses IndexSet to remove from [AnyStat] and ModelContext
            //TODO: Research this more
            StatUtility.Remove(offsets: offsets, statItems: &stats, modelContext: modelContext)
        }
    }
    
    func addDecimal() {
        let decimal = DecimalStat(name: name, date: date, unitName: unitName)
        modelContext.insert(decimal)
        path.append(decimal)
    }

//    func addCounter() {
//        let counter = CounterStat(name: "test counter", created: Date())
//        modelContext.insert(counter)
//        print(modelContext.sqliteCommand)
//    }
}


#Preview {
    MainActor.assumeIsolated {
        ContentView()
            .modelContainer(for: CounterStat.self)
    }
}
