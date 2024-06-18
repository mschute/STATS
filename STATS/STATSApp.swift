//
//  STATSApp.swift
//  STATS
//
//  Created by Staff on 10/06/2024.
//

import SwiftData
import SwiftUI


@main
struct STATSApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            DecimalStat.self, CounterStat.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
