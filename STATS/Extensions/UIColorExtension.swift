import UIKit
import SwiftUI

// Color Extension: https://stackoverflow.com/questions/56487679/how-do-i-easily-support-light-and-dark-mode-with-a-custom-color-used-in-my-app
//Return colour on color scheme
extension UIColor {
    static func dynamicMainColor(colorScheme: ColorScheme) -> UIColor {
        
        let lightColor = UIColor(red: 181/255.0, green: 131/255.0, blue: 255/255.0, alpha: 1.0)
        let darkColor = UIColor(red: 155/255.0, green: 81/255.0, blue: 224/255.0, alpha: 1.0)
        
        return colorScheme == .dark ? darkColor : lightColor
    }
}
