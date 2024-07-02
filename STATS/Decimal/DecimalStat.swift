import Foundation
import SwiftData
import SwiftUI

@Model
class DecimalStat: Stat, Identifiable {
    var name: String
    var created: Date
    var unitName: String
    @Relationship(deleteRule: .cascade) var statEntry = [DecimalEntry]()
    
    init(name: String, created: Date, unitName: String, statEntry: [DecimalEntry] = [DecimalEntry]()) {
        self.name = name
        self.created = created
        self.unitName = unitName
        self.statEntry = statEntry
    }

//TODO: Do I want to add functions to the model?
//    func Delete(modelContext: ModelContext) {
//        var temp = "temp code"
//    }
//
//    func detailView() -> AnyView {
//        AnyView(DecimalDetail(stat: self))
//    }
}
