import SwiftUI

struct CounterEntryForm: View {
    @Bindable var counterStat: CounterStat
    
    @State var value = ""
    @State var timestamp = Date.now
    
    @State private var newCounterEntry = ""
    
    var body: some View {
        Form(content: {
            HStack{
                Text("Value ")
                TextField("Value", text: $value)
            }
            
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
            
            Button("Add", action: addEntry)
        
        })
        
    }
    
    func addEntry() {
        guard newCounterEntry.isEmpty == false else { return }
        
        withAnimation{
            let entry = CounterEntry(value: 1, counterEntryID: UUID(), timestamp: Date())
            counterStat.statCounterEntry.append(entry)
            newCounterEntry = ""
        }
    }
}

#Preview {
    CounterEntryForm(counterStat: CounterStat(name: "No Smoking", created: Date()), value: "1", timestamp: Date())
}
