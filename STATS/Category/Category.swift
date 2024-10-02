import Foundation
import SwiftData
import SwiftUI

@Model
final class Category: Identifiable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Category {
    static func addCategory(newCategory: String, alertMessage: inout String, showAlert: inout Bool, modelContext: ModelContext) {
        
        if !validateCategory(category: newCategory, alertMessage: &alertMessage, showAlert: &showAlert, modelContext: modelContext) {
            return
        }
        
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

extension Category {
    static func validateCategory(category: String, alertMessage: inout String, showAlert: inout Bool, modelContext: ModelContext) -> Bool {
        if(category.isEmpty) {
            alertMessage = "Must add a tag name"
            showAlert = true
            return false
        } else if(categoryExists(categoryName: category, modelContext: modelContext)) {
            alertMessage = "This tag already exists"
            showAlert = true
            return false
        }
        return true
    }
    
    static func categoryExists(categoryName: String, modelContext: ModelContext) -> Bool {
        let lowercasedCategoryName = categoryName.lowercased()
        let fetchDescriptor = FetchDescriptor<Category>()
        
        do {
            let results = try modelContext.fetch(fetchDescriptor)
            return results.contains { $0.name.lowercased() == lowercasedCategoryName }
        } catch {
            return false
        }
    }
}
