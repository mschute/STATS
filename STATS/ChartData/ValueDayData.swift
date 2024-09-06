import Foundation

// Data usable with Charts
//TODO: Create a set of data for week at a time
//TODO: Create a set of data for month at a time
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
