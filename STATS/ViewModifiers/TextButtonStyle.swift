import SwiftUI

struct TextButtonStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var fontSize: CGFloat
    var verticalPadding: CGFloat
    var horizontalPadding: CGFloat
    var align: Alignment
    var statColor: Color
    
    // Font is changed to purple without setting it explicitly
    private var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Menlo", size: fontSize))
            .fontWeight(.semibold)
            .foregroundColor(textColor)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(statColor)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: align)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

extension View {
    func textButtonStyle(fontSize: CGFloat, verticalPadding: CGFloat, horizontalPadding: CGFloat, align: Alignment, statColor: Color) -> some View {
        self.modifier(TextButtonStyle(fontSize: fontSize, verticalPadding: verticalPadding, horizontalPadding: horizontalPadding, align: align, statColor: statColor))
    }
}
