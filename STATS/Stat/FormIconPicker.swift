import SwiftUI
import SymbolPicker

struct FormIconPicker: View {
    @Binding var iconPickerPresented: Bool
    @Binding var icon: String
    
    var body: some View {
        HStack {
            Text("Icon")
            Button {
                iconPickerPresented = true
            } label: {
                HStack {
                    Image(systemName: icon)
                    Image(systemName: "chevron.right")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.black)
            }
            .sheet(isPresented: $iconPickerPresented) {
                SymbolPicker(symbol: $icon)
            }
        }
    }
}

//#Preview {
//    FormIconPicker()
//}
