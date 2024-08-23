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
                                    Category.deleteItems(offsets: IndexSet(integer: index), categories: categories, modelContext: modelContext)
                                }
                                Haptics.shared.play(.light)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .tint(.cancel)
                }
                
                Section {
                    TextField("New category", text: $newCategory)
                    
                    Button("Add") {}
                        .buttonStyle(StatButtonStyle(fontSize: 16, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: .main, statHighlightColor: .mainHighlight))
                        .padding(.vertical, 5)
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    Category.addCategory(newCategory: newCategory, modelContext: modelContext)
                                    Haptics.shared.play(.light)
                                }
                        )
                }
            }
        }
        .dismissKeyboard()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

