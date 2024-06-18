//
//  AddStat.swift
//  STATS
//
//  Created by Staff on 11/06/2024.
//

import SwiftUI
import SwiftData

struct CounterForm: View {
    @Bindable var counterStat: CounterStat
    @State private var newCounterEntry = ""
    
    var body: some View {
        Form {
            TextField("Title", text: $counterStat.name)
            
            Section("Entries"){
                ForEach(counterStat.statCounterEntry) { entry in
                    Text("Value: \(entry.value)")
                    
                }
                
                HStack {
                    TextField("Add a new entry in \(counterStat.name)", text: $newCounterEntry)
                    
                    Button("Add", action: addEntry)
                }
            }
        }
        .navigationTitle("Edit Counter Stat")
        .navigationBarTitleDisplayMode(.inline)
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
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: CounterStat.self, configurations: config)
            let example = CounterStat(name: "Weight", created: Date())
            
            return CounterForm(counterStat: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create error")
        }
    }
