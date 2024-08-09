import SwiftData
import SwiftUI

struct EditCategory: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Category.name) var categories: [Category]
    
    @State private var newCategory = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            TopBar(title: "MANAGE TAGS", topPadding: 0, bottomPadding: 20)
            List {
                ForEach(categories) { category in
                    Text("\(category.name)")
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                if let index = categories.firstIndex(of: category) {
                                    deleteItems(offsets: IndexSet(integer: index))
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .tint(.cancel)
                }
                
                Section {
                    TextField("New category", text: $newCategory)
                    
                    Button(action: addCategory) {
                        Text("Add")
                            .textButtonStyle(fontSize: 16, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: .main, statHighlightColor: .mainHighlight)
                            .padding(.vertical, 5)
                    }
                }
            }
        }
        .dismissKeyboardOnTap()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        do {
            modelContext.insert(Category(name: newCategory))
            try modelContext.save()
        } catch {
            print("Error adding category")
        }
        newCategory = ""
    }
}
