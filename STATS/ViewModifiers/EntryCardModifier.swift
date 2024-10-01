import SwiftUI

struct EntryCardModifier: ViewModifier {
    var gradientColor: Color
    var gradientHighlight: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Menlo", size: 13))
            .padding()
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientFilter(gradientColor: gradientColor, gradientHighlight: gradientHighlight)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

extension View {
    func entryCardModifier(gradientColor: Color, gradientHighlight: Color) -> some View {
        self.modifier(EntryCardModifier(gradientColor: gradientColor, gradientHighlight: gradientHighlight))
    }
}




