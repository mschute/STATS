import SwiftUI

//Keyboard implementation: https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui#comment109419055_60010955
struct HideKeyboardGestureModifier: ViewModifier {
    @Environment(\.keyboardIsShown) var keyboardIsShown

    
    func body(content: Content) -> some View {
        content
            .gesture(TapGesture().onEnded {
                UIApplication.shared.resignCurrentResponder()
            }, including: keyboardIsShown ? .all : .none)
    }
}

extension UIApplication {
    func resignCurrentResponder() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}

extension View {
    // Assign a tap gesture that dismisses the first responser only when the keyboard is visible to the KeyboardIsShown EnvironmentKey
    func dismissKeyboardOnTap() -> some View {
        modifier(HideKeyboardGestureModifier())
    }
    
    // Shortcut to close in a function call
    func resignCurrentResponder() {
        UIApplication.shared.resignCurrentResponder()
    }
}

extension EnvironmentValues {
    var keyboardIsShown: Bool {
        get { return self[KeyboardIsShownEVK.self] }
        set { self[KeyboardIsShownEVK.self] = newValue }
    }
}

private struct KeyboardIsShownEVK: EnvironmentKey {
    static let defaultValue: Bool = false
}
