//
//  CounterEntry.swift
//  STATS
//
//  Created by Staff on 11/06/2024.
//

import Foundation
import SwiftData

@Model
//does this need to conform to Identifiable?
class CounterEntry {
    var counterCounter: String
    //var counterEntryID: UUID
//    var timestamp: Date
//    var notes: String
    
//    init(counterEntryID: UUID, timestamp: Date = .now, notes: String = "") {
//        self.counterEntryID = counterEntryID
//        self.timestamp = timestamp
//        self.notes = notes
//    }
    
    init(counterCounter: String) {
        self.counterCounter = counterCounter
    }
}
