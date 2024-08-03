import SwiftUI

// Implementation: https://useyourloaf.com/blog/swiftui-custom-environment-values/
struct BackgroundColor: EnvironmentKey {
    static let defaultValue: Color = .background
}

extension EnvironmentValues {
    var backgroundColor: Color {
        get { self[BackgroundColor.self] }
        set { self[BackgroundColor.self] = newValue }
    }
}

