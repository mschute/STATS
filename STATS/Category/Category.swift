import Foundation
import SwiftData
import SwiftUI

@Model 
class Category: Identifiable {
    var id: UUID
    var name: String
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}

extension Category {
    static func addCategory(newCategory: String, modelContext: ModelContext){
        modelContext.insert(Category(name: newCategory))
    }
    
    //Used IndexSet instead of Index for future scalability
    static func deleteItems(offsets: IndexSet, categories: [Category],  modelContext: ModelContext) {
        withAnimation {
            for index in offsets {
                modelContext.delete(categories[index])
            }
        }
    }
}
