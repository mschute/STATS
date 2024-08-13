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
    }
}

extension View {
    func gradientFilter(gradientColor: Color, gradientHighlight: Color, cornerRadius: CGFloat) -> some View {
        self.modifier(GradientFilter(gradientColor: gradientColor, gradientHighlight: gradientHighlight, cornerRadius: cornerRadius))
    }
}
