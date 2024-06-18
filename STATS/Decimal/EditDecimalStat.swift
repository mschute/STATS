//
//  EditDecimalStat.swift
//  STATS
//
//  Created by Staff on 13/06/2024.
//

import SwiftUI
import SwiftData

struct EditDecimalStat: View {
    @Bindable var decimalStat: DecimalStat
    @State private var newDecimalEntry = ""
    
    var body: some View {
        Text("Edit Decimal Stat")
//        Form {
//            TextField("Title", text: $decimalStat.title)
//            TextField("Custom Unit", text: $decimalStat.unitName, axis: .vertical)
//            
//            //            Section("Entries"){
//            //                ForEach(statDecimal.statDecimalEntry) { entry in
//            //                    Text(entry.)
//            //                    
//            //                }
//            
//            //                HStack {
//            //                    TextField("Add a new entry in \(statCounter.title)", text: $newCounterEntry)
//            //                    
//            //                    Button("Add", action: addEntry)
//            //                }
//        }
//        .navigationTitle("Edit Decimal Stat")
//        .navigationBarTitleDisplayMode(.inline)
//    }
    
//        func addEntry() {
//            guard newDecimalEntry.isEmpty == false else { return }
//            
//            withAnimation{
//                let entry = DecimalEntry(value: (Double) newDecimalEntry)
//                statDecimal.statDecimalEntry.append(entry)
//                newDecimalEntry = ""
//            }
//        }
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
}
