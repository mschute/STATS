//
//  DecimalEntry.swift
//  STATS
//
//  Created by Staff on 12/06/2024.
//

import Foundation
import SwiftData

@Model
//TODO: Should I set this to have a relationship with DecimalStat?
//TODO: Reorganize order of attributes
class DecimalEntry: Identifiable {
    var decimalStat: DecimalStat
    var value: Double
    var decimalEntryID: UUID
    var timestamp: Date
    
    init(decimalStat: DecimalStat, value: Double, decimalEntryID: UUID, timestamp: Date) {
        self.decimalStat = decimalStat
        self.value = value
        self.decimalEntryID = decimalEntryID
        self.timestamp = timestamp
    }
}
