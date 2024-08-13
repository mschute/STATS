import SwiftUI

struct NoDataSection: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        VStack {
            content
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(colorScheme == .dark ? Color(UIColor.systemGray6) : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                .padding(40)
        }
    }
}

extension View {
    func noDataSection() -> some View {
        self.modifier(NoDataSection())
    }
}
