//
//  DecimalEntry.swift
//  STATS
//
//  Created by Staff on 12/06/2024.
//

import Foundation
import SwiftData

@Model
//TODO: Should I set DecimalStat to @Relationship?
class DecimalEntry: Identifiable {
    var decimalEntryID: UUID
    var decimalStat: DecimalStat
    var timestamp: Date
    var value: Double
    
    init(decimalStat: DecimalStat, decimalEntryID: UUID, timestamp: Date, value: Double) {
        self.decimalStat = decimalStat
        self.decimalEntryID = decimalEntryID
        self.timestamp = timestamp
        self.value = value
    }
}
