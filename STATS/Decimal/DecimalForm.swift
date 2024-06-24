//
//  EditDecimalStat.swift
//  STATS
//
//  Created by Staff on 13/06/2024.
//

import SwiftUI
import SwiftData

//TODO: Should this be a separate form to Add? Delete this?
struct DecimalForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedTab: Int
    
    @State private var name = ""
    @State private var unitName = ""
    @State private var created = Date()
    
    var body: some View {
        Text("Add Decimal Stat")
            .font(.largeTitle)
        
        Form {
            TextField("Title", text: $name)
            TextField("Unit name", text: $unitName)
        }
        .navigationBarTitleDisplayMode(.inline)
        
        Button("Add Decimal"){
            addDecimal(name: name, created: created, unitName: unitName)
        }
        .padding()
        .buttonStyle(.plain)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(10)
        
        Spacer()
    }
    
    func addDecimal(name: String, created: Date, unitName: String) {
        let decimal = DecimalStat(name: name, created: created, unitName: unitName)
        modelContext.insert(decimal)
        dismiss()
        selectedTab = 1
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
