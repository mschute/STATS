import Foundation

// Data usable with Charts
struct ValueDayData: Identifiable {
    var id: UUID
    var day: Date
    var value: Double
    
    init(day: Date, value: Double) {
        self.id = UUID()
        self.day = day
        self.value = value
    }
}
