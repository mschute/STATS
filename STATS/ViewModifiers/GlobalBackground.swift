import Foundation
import SwiftUI

struct GlobalBackground: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(globalBackgroundColor())
    }
    
    private func globalBackgroundColor() -> Color {
        if colorScheme == .light {
            Color(UIColor.systemGray6)
        } else {
            Color(UIColor.systemGroupedBackground)
        }
    }
}

extension View {
    func globalBackground() -> some View {
        self.modifier(GlobalBackground())
    }
}
