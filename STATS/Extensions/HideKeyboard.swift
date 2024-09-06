import SwiftUI

//Keyboard implementation: https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui#comment109419055_60010955
struct HideKeyboard: ViewModifier {
    //Holds bool to determine if keyboard is shown
    @Environment(\.keyboardIsShown) var keyboardIsShown
    
    func body(content: Content) -> some View {
        content
        // Adds tap gesture to view, execute code when tap ends
            .gesture(TapGesture().onEnded {
                //Dismisses keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                //Specifies when the tap gesture is ativated (i.e. only when keyboard is showing)
            }, including: keyboardIsShown ? .all : .none)
    }
}

extension View {
    // function to call the view modifier in a view
    func dismissKeyboard() -> some View {
        modifier(HideKeyboard())
    }
}

//Will add environment value to SwiftUI environment - so it can check if the keyboard is visible
extension EnvironmentValues {
    //Computed property to read or write to the keyboardIsShown EV
    var keyboardIsShown: Bool {
        get { return self[KeyboardIsShownEVK.self] }
        set { self[KeyboardIsShownEVK.self] = newValue }
    }
}

private struct KeyboardIsShownEVK: EnvironmentKey {
    static let defaultValue: Bool = false
}
