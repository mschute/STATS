import SwiftData
import SwiftUI

struct FormCategoryPicker: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @Binding var newCategory: String
    @Binding var chosenCategory: Category?
    @Binding var addNewCategory: Bool
    
    //TODO: Create custom multiple picker with SwiftUI, implement if time https://www.fline.dev/multi-selector-in-swiftui/
    //optional picker https://stackoverflow.com/questions/59348093/picker-for-optional-data-type-in-swiftui
    var body: some View {
        Section(header: Text("Category")) {
            Picker("Select a tag", selection: $chosenCategory) {
                Text("").tag(nil as Category?)
                ForEach(categories) { option in
                    Text(option.name)
                        .tag(option as Category?)
                }
            }
            
            if !addNewCategory {
                Button("Add new tag") {
                    addNewCategory = true
                }
            }
            
            if addNewCategory {
                TextField("Add new tag", text: $newCategory)
                HStack{
                    Button("Add") {
                        addCategory(newCategory: newCategory)
                        newCategory = ""
                        addNewCategory = false
                    }
                    Button("Cancel") {
                        newCategory = ""
                        addNewCategory = false
                    }
                }
            }
        }
    }

    //TODO: May need to extract this out to the StatUtility and remove private, make it switchable? (maybe thats not necessary)
    private func addCategory(newCategory: String){
        modelContext.insert(Category(name: newCategory))
    }
}
//#Preview {
//    FormCategoryPicker()
//}
