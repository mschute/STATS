//
//  ReminderFrequencyEnum.swift
//  STATS
//
//  Created by Staff on 11/06/2024.
//

import Foundation

enum Frequency: String, Codable {
    case multipleDaily = "Multiple times per day"
    case daily = "Daily"
    case everyOtherDay = "Every other day"
    case multipleDaysPerWeek = "Multiple times per week"
    case weekly = "Weekly"
    case monthly = "Monthly"
    case annually = "Annually"
}
