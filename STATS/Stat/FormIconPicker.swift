import SwiftUI
import SymbolPicker

struct FormIconPicker: View {
    @Binding var iconPickerPresented: Bool
    @Binding var icon: String
    
    var statColor: Color
    
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
                .tint(statColor)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .sheet(isPresented: $iconPickerPresented) {
                SymbolPicker(symbol: $icon)
            }
        }
    }
}
