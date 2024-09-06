import Foundation
import SwiftUI

// Added to get rid of background spacing between header and form in light mode
struct GlobalBackground: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(globalBackgroundColor())
    }
    
    private func globalBackgroundColor() -> Color {
        Color(colorScheme == .light ? UIColor.systemGray6 : UIColor.systemGroupedBackground)
    }
}

extension View {
    func globalBackground() -> some View {
        self.modifier(GlobalBackground())
    }
}
