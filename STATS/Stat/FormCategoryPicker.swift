import SwiftData
import SwiftUI

struct FormCategoryPicker: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Category.name) var categories: [Category]
    
    @Binding var newCategory: String
    @Binding var chosenCategory: Category?
    @Binding var addNewCategory: Bool
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var statColor: Color
    var statHighlightColor: Color
    
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
                    Haptics.shared.play(.light)
                }
                .buttonStyle(StatButtonStyle(fontSize: 15, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: statColor, statHighlightColor: statHighlightColor))
                .padding(.vertical)
  
            } else {
                TextField("Add new tag", text: $newCategory)
                HStack(spacing: 10) {
                    Button("Add") {
                        Category.addCategory(newCategory: newCategory, alertMessage: &alertMessage, showAlert: &showAlert, modelContext: modelContext)
                        newCategory = ""
                        addNewCategory = false
                        if !showAlert {
                            Haptics.shared.play(.light)
                        }
                    }
                    .buttonStyle(StatButtonStyle(fontSize: 15, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: statColor, statHighlightColor: statHighlightColor))

                    Button("Cancel") {
                        newCategory = ""
                        addNewCategory = false
                        Haptics.shared.play(.light)
                    }
                    .buttonStyle(StatButtonStyle(fontSize: 15, verticalPadding: 10, horizontalPadding: 20, align: .leading, statColor: .cancel, statHighlightColor: .cancelHighlight))
                }
                .padding(.vertical)
                .frame(alignment: .leading)
            }
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}
