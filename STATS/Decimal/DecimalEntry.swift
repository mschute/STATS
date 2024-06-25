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
    var decimalStat: DecimalStat
    var decimalEntryId: UUID
    var timestamp: Date
    var value: Double
    
    init(decimalStat: DecimalStat, decimalEntryId: UUID, timestamp: Date, value: Double) {
        self.decimalStat = decimalStat
        self.decimalEntryId = decimalEntryId
        self.timestamp = timestamp
        self.value = value
    }
}
