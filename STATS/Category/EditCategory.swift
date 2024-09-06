import SwiftData
import SwiftUI

struct EditCategory: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Category.name) var categories: [Category]
    
    @State private var newCategory: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            TopBar(title: "MANAGE TAGS", topPadding: 20, bottomPadding: 20)
            List {
                ForEach(categories) { category in
                    Text("\(category.name)")
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                //TODO: Change to delete directly in the view?
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
                    TextField("New tag", text: $newCategory)
                    
                    Button("Add") {}
                        .buttonStyle(StatButtonStyle(fontSize: 16, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: .main, statHighlightColor: .mainHighlight, customTextColor: .white))
                        .padding(.vertical, 5)
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    Category.addCategory(newCategory: newCategory, alertMessage: &alertMessage, showAlert: &showAlert, modelContext: modelContext)
                                    newCategory = ""
                                    if !showAlert {
                                        Haptics.shared.play(.light)
                                    }
                                }
                        )
                }
            }
        }
        .dismissKeyboard()
        .globalBackground()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                Haptics.shared.play(.light)
            }
        }
    }
}
