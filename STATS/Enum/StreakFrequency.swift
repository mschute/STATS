import Foundation
import SwiftUI

//Picker for Enum: https://forums.developer.apple.com/forums/thread/126706
//Enum with SwiftData needs to be Codable: https://www.hackingwithswift.com/quick-start/swiftdata/using-structs-and-enums-in-swiftdata-models
enum StreakFrequency: String, CaseIterable, Codable, Equatable  {
    case multipleDaily = "Multiple times per day"
    case daily = "Daily"
    case everyOtherDay = "Every other day"
    case multipleDaysPerWeek = "Multiple times per week"
    case weekly = "Weekly"
    case monthly = "Monthly"
    case annually = "Annually"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
