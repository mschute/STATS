//
//  File.swift
//  STATS
//
//  Created by Staff on 12/06/2024.
//

import Foundation
import SwiftData

@Model
class Decimal: Stat, Identifiable {
    @Attribute(.unique) var name: String
    
    var created: Date
    var unitName: String

    @Relationship(deleteRule: .cascade) var statDecimalEntry = [DecimalEntry]()
    
    init(name: String, date: Date, unitName: String, statDecimalEntry: [DecimalEntry] = [DecimalEntry]()) {
        self.name = name
        self.created = date
        self.unitName = unitName
        self.statDecimalEntry = statDecimalEntry
    }
}
