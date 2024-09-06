import SwiftUI

struct TextButtonStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var fontSize: CGFloat
    var verticalPadding: CGFloat
    var horizontalPadding: CGFloat
    var align: Alignment
    var statColor: Color
    var statHighlightColor: Color
    var customTextColor: Color? = nil

    private var textColor: Color {
        customTextColor ?? (colorScheme == .dark ? .white : .black)
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Menlo", size: fontSize))
            .fontWeight(.semibold)
            .foregroundColor(textColor)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
        //TODO: Either remove this clip shape or separate the cornerRadius from the gradientFilter
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .frame(maxHeight: 60, alignment: align)
            .gradientFilter(gradientColor: statColor, gradientHighlight: statHighlightColor, cornerRadius: 10.0)
    }
}

extension View {
    func textButtonStyle(fontSize: CGFloat, verticalPadding: CGFloat, horizontalPadding: CGFloat, align: Alignment, statColor: Color, statHighlightColor: Color) -> some View {
        self.modifier(TextButtonStyle(fontSize: fontSize, verticalPadding: verticalPadding, horizontalPadding: horizontalPadding, align: align, statColor: statColor, statHighlightColor: statHighlightColor))
    }
}
