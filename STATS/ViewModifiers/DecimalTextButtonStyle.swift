import SwiftUI

struct DecimalTextButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .medium, design: .default))
            .padding(.vertical, 20)
            .padding(.horizontal, 50)
            .background(Color.decimal)
            .foregroundStyle(.black)
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
