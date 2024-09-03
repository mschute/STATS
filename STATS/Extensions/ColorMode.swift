import SwiftUI

//https://stackoverflow.com/questions/68387187/how-to-use-uiwindowscene-windows-on-ios-15
//https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0
//https://www.hackingwithswift.com/forums/swiftui/preferredcolorscheme-not-affecting-datepicker-and-confirmationdialog/11796
//https://medium.com/@Lakshmnaidu/ios-darkmode-light-adoption-swift-d941d84b481f
extension UIApplication {
    //Find the active window displaying content
    var keyWindow: UIWindow? {
        return self.connectedScenes
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene})?.windows
            .first(where: \.isKeyWindow)
    }
    
    //Apply dark/light mode to key window
    func applyColorMode(isDarkMode: Bool) {
        if #available(iOS 15, *) {
            keyWindow?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}
