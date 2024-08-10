import UIKit
import SwiftUI

//Haptic Singleton: https://stackoverflow.com/questions/56748539/how-to-create-haptic-feedback-for-a-button-in-swiftui/
// https://codakuma.com/swiftui-haptics/
class Haptics {
    static let shared = Haptics()
    
    @AppStorage("isHaptics") private var isHaptics: Bool = true
    
    private init() { }

    //Early exit: https://reintech.io/blog/how-to-use-swift-early-exit
    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        guard isHaptics else { return }
        
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
}
