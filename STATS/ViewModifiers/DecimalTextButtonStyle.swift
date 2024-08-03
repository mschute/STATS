import SwiftUI

struct DecimalTextButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Menlo", size: 20))
            .fontWeight(.semibold)
            .padding(.vertical, 20)
            .padding(.horizontal, 50)
            .background(Color.decimal)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

extension View {
    func decimalTextStyle() -> some View {
        self.modifier(DecimalTextButtonStyle())
    }
}
