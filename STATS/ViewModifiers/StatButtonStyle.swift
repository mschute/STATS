import SwiftUI

struct StatButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    var fontSize: CGFloat
    var verticalPadding: CGFloat
    var horizontalPadding: CGFloat
    var align: Alignment
    var statColor: Color
    var statHighlightColor: Color

    // Font is changed to purple without setting it explicitly
    private var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Menlo", size: fontSize))
            .fontWeight(.semibold)
            .foregroundColor(textColor)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .frame(alignment: align)
            .gradientFilter(gradientColor: statColor, gradientHighlight: statHighlightColor, cornerRadius: 10)
    }
}
