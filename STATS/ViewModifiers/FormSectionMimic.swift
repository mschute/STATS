import SwiftUI

struct FormSectionMimic: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .frame(alignment: .center)
            .background(colorScheme == .dark ? Color(UIColor.systemGray6) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding(.top, 35)
            .padding(.horizontal, 15)
    }
}

extension View {
    func formSectionMimic() -> some View {
        self.modifier(FormSectionMimic())
    }
}
