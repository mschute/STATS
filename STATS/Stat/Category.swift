import Foundation
import SwiftData

@Model 
class Category: Identifiable {
    var id: UUID
    var name: String

    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}
