import SwiftUI

struct StatButtonStyle: ButtonStyle {
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
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Menlo", size: fontSize))
            .fontWeight(.semibold)
            .foregroundColor(textColor)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .frame(alignment: align)
            .gradientFilter(gradientColor: statColor, gradientHighlight: statHighlightColor)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
    }
}
