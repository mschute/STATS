import SwiftData
import SwiftUI

struct EditTags: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @State var newCategory = ""
    
    var body: some View {
        List {
            ForEach(categories) { category in
                Text("\(category.name)")
            }
            .onDelete(perform: deleteItems)
            
            Section {
                TextField("Add new category", text: $newCategory)
                Button(action: addCategory) {
                    Text("Add")
                }
            }
        }
        .navigationTitle("Manage Tags")
        

    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                do {
                    modelContext.delete(categories[index])
                    try modelContext.save()
                } catch {
                        print("Error deleting category")
                    }
            }
        }
    }
    
    private func addCategory(){
        modelContext.insert(Category(name: newCategory))
        newCategory = ""
    }
}

//#Preview {
//    EditTags()
//}
