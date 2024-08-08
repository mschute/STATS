import SwiftUI

struct GradientFilter: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var gradientColor: Color
    var gradientHighlight: Color
    var cornerRadius: CGFloat
    var lineHighlight: Color {
        colorScheme == .dark ? .black : .white
    }
    
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [gradientColor, gradientHighlight]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineHighlight.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: Color(.counterHighlight).opacity(0.4), radius: 10, x: 0, y: 5)
    }
}

extension View {
    func gradientFilter(gradientColor: Color, gradientHighlight: Color, cornerRadius: CGFloat) -> some View {
        self.modifier(GradientFilter(gradientColor: gradientColor, gradientHighlight: gradientHighlight, cornerRadius: cornerRadius))
    }
}
