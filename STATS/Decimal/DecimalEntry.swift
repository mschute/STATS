//
//  DecimalEntry.swift
//  STATS
//
//  Created by Staff on 12/06/2024.
//

import Foundation
import SwiftData

@Model
//does this need to conform to Identifiable?
class DecimalEntry {
    var value: Double
//    var decimalEntryID: UUID
//    var timestamp: Date
//    var notes: String
    
//    init(counterEntryID: UUID, timestamp: Date = .now, value: Double = 0.0, notes: String = "") {
//        self.counterEntryID = counterEntryID
//        self.timestamp = timestamp
//        self.value = value
//        self.notes = notes
//    }
    
    init(value: Double) {
        self.value = value
    }
}
