import SwiftUI

struct StatCardModifier: ViewModifier {
    var gradientColor: Color
    var gradientHighlight: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: gradientColor, gradientHighlight: gradientHighlight)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

extension View {
    func statCardModifier(gradientColor: Color, gradientHighlight: Color) -> some View {
        self.modifier(StatCardModifier(gradientColor: gradientColor, gradientHighlight: gradientHighlight))
    }
}

