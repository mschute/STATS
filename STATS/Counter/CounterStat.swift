//
//  StatsCounter.swift
//  STATS
//
//  Created by Staff on 11/06/2024.
//

import Foundation
import SwiftData

@Model
class Counter: Stat, Identifiable {
    @Attribute(.unique) var name: String
    
    var created: Date
    var value: Int
    @Relationship(deleteRule: .cascade) var statCounterEntry = [CounterEntry]()
    
    init(name: String, created: Date, value: Int, statCounterEntry: [CounterEntry] = [CounterEntry]()) {
        self.name = name
        self.created = created
        self.value = value
        self.statCounterEntry = statCounterEntry
    }
}
