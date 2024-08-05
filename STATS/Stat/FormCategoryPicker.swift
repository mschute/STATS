import SwiftData
import SwiftUI

struct FormCategoryPicker: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Category.name) var categories: [Category]
    
    @Binding var newCategory: String
    @Binding var chosenCategory: Category?
    @Binding var addNewCategory: Bool
    
    @State var statColor: Color
    
    //optional picker https://stackoverflow.com/questions/59348093/picker-for-optional-data-type-in-swiftui
    var body: some View {
        Section(header: Text("Category").foregroundColor(statColor).fontWeight(.medium)) {
            Picker("Select a tag", selection: $chosenCategory) {
                Text("").tag(nil as Category?)
                ForEach(categories) { option in
                    Text(option.name)
                        .tag(option as Category?)
                }
                .tint(statColor)
            }
            .fontWeight(.medium)
            
            if !addNewCategory {
                Button("Add tag") {
                    addNewCategory = true
                }
                .buttonStyle(StatButtonStyle(fontSize: 15, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: statColor))
                .padding(.vertical)
            } else {
                TextField("Add new tag", text: $newCategory)
                HStack(spacing: 10) {
                    Button("Add") {
                        addCategory(newCategory: newCategory)
                        newCategory = ""
                        addNewCategory = false
                    }
                    .buttonStyle(StatButtonStyle(fontSize: 15, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: statColor))

                    Button("Cancel") {
                        newCategory = ""
                        addNewCategory = false
                    }
                    .buttonStyle(StatButtonStyle(fontSize: 15, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: .cancel))
                }
                .padding(.vertical)
                .frame(alignment: .leading)
            }
        }
    }

    private func addCategory(newCategory: String){
        modelContext.insert(Category(name: newCategory))
    }
}
