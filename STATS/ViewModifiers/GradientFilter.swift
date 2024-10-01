import SwiftUI

struct GradientFilter: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var gradientColor: Color
    var gradientHighlight: Color
    
    //TODO: Separate clipshape from gradient to follow single responsibility principle and promote reusability
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: colorScheme == .light ? [gradientHighlight, gradientColor] : [gradientColor, gradientHighlight]), startPoint: .top, endPoint: .bottom))
    }

}

extension View {
    func gradientFilter(gradientColor: Color, gradientHighlight: Color) -> some View {
        self.modifier(GradientFilter(gradientColor: gradientColor, gradientHighlight: gradientHighlight))
    }
}
