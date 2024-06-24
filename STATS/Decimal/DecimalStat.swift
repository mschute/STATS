//
//  File.swift
//  STATS
//
//  Created by Staff on 12/06/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class DecimalStat: Stat, Identifiable {
    var name: String
    var created: Date
    var unitName: String

    @Relationship(deleteRule: .cascade) var statDecimalEntry = [DecimalEntry]()
    
    init(name: String, created: Date, unitName: String, statDecimalEntry: [DecimalEntry] = [DecimalEntry]()) {
        self.name = name
        self.created = created
        self.unitName = unitName
        self.statDecimalEntry = statDecimalEntry
    }
    
//    func Delete(modelContext: ModelContext) {
//        var temp = "temp code"
//    }
//    
//    func detailView() -> AnyView {
//        AnyView(DecimalDetail(stat: self))
//    }
}
